import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:partie/database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BackupManifest {
  const BackupManifest({
    required this.schemaVersion,
    required this.dbFilename,
    required this.createdAt,
  });

  final int schemaVersion;
  final String dbFilename;
  final String createdAt;

  Map<String, dynamic> toJson() => {
    'schemaVersion': schemaVersion,
    'dbFilename': dbFilename,
    'createdAt': createdAt,
  };

  static BackupManifest fromJson(Map<String, dynamic> json) => BackupManifest(
    schemaVersion: json['schemaVersion'] as int,
    dbFilename: json['dbFilename'] as String,
    createdAt: json['createdAt'] as String,
  );
}

class BackupArchive {
  static const _dbFilename = 'partie_database.sqlite';
  static const _manifestEntry = 'manifest.json';
  static const _imagesPrefix = 'images/';

  static String _basenameAny(String path) {
    final idx = path.lastIndexOf(RegExp(r'[\/\\]'));
    return idx >= 0 ? path.substring(idx + 1) : path;
  }

  static Future<Uint8List> buildBackupZip() async {
    await db.customStatement('PRAGMA wal_checkpoint(TRUNCATE);');

    final supportDir = await getApplicationSupportDirectory();
    final dbFile = File(p.join(supportDir.path, _dbFilename));
    final dbBytes = await dbFile.readAsBytes();

    final manifest = BackupManifest(
      schemaVersion: db.schemaVersion,
      dbFilename: _dbFilename,
      createdAt: DateTime.now().toUtc().toIso8601String(),
    );

    final archive = Archive();
    archive.add(
      ArchiveFile.bytes(
        _manifestEntry,
        utf8.encode(jsonEncode(manifest.toJson())),
      ),
    );
    archive.add(ArchiveFile.bytes(_dbFilename, dbBytes));

    final partsWithImages =
        await db.managers.parts
            .filter((f) => f.catalogImagePath.isNotNull())
            .get();
    final seenBasenames = <String>{};
    for (final part in partsWithImages) {
      final path = part.catalogImagePath!;
      final basename = _basenameAny(path);
      if (!seenBasenames.add(basename)) continue;

      final file = File(path);
      if (!await file.exists()) continue;

      archive.add(
        ArchiveFile.bytes('$_imagesPrefix$basename', await file.readAsBytes()),
      );
    }

    final encoded = ZipEncoder().encodeBytes(archive);
    return Uint8List.fromList(encoded);
  }

  static Future<void> restoreFromZip(File zipFile) async {
    final bytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);

    final manifestFile = archive.files.firstWhere(
      (f) => f.name == _manifestEntry,
      orElse: () => throw const FormatException('Missing manifest.json'),
    );
    final manifest = BackupManifest.fromJson(
      jsonDecode(utf8.decode(manifestFile.content as List<int>))
          as Map<String, dynamic>,
    );

    if (manifest.schemaVersion > db.schemaVersion) {
      throw StateError(
        'Backup schema (${manifest.schemaVersion}) is newer than this app '
        'supports (${db.schemaVersion}). Update the app and try again.',
      );
    }

    final dbEntry = archive.files.firstWhere(
      (f) => f.name == manifest.dbFilename,
      orElse:
          () => throw FormatException(
            'Missing ${manifest.dbFilename} in archive',
          ),
    );

    final supportDir = await getApplicationSupportDirectory();

    for (final entry in archive.files) {
      if (!entry.isFile) continue;
      if (!entry.name.startsWith(_imagesPrefix)) continue;
      final basename = entry.name.substring(_imagesPrefix.length);
      if (basename.isEmpty) continue;

      final out = File(p.join(supportDir.path, basename));
      await out.writeAsBytes(entry.content as List<int>, flush: true);
    }

    final stagingPath = p.join(supportDir.path, '$_dbFilename.staging');
    final stagingFile = File(stagingPath);
    if (await stagingFile.exists()) await stagingFile.delete();
    await stagingFile.writeAsBytes(
      dbEntry.content as List<int>,
      flush: true,
    );

    final stagingDb = AppDatabase(NativeDatabase(stagingFile));
    try {
      await stagingDb.transaction(() async {
        final parts =
            await stagingDb.managers.parts
                .filter((f) => f.catalogImagePath.isNotNull())
                .get();
        for (final part in parts) {
          final basename = _basenameAny(part.catalogImagePath!);
          final newPath = p.join(supportDir.path, basename);
          await stagingDb.managers.parts
              .filter((f) => f.id.equals(part.id))
              .update((row) => row(catalogImagePath: Value(newPath)));
        }
      });
    } finally {
      await stagingDb.close();
    }

    await db.close();

    final livePath = p.join(supportDir.path, _dbFilename);
    final liveFile = File(livePath);
    final liveWal = File('$livePath-wal');
    final liveShm = File('$livePath-shm');

    if (await liveFile.exists()) await liveFile.delete();
    if (await liveWal.exists()) await liveWal.delete();
    if (await liveShm.exists()) await liveShm.delete();

    await stagingFile.rename(livePath);
  }
}
