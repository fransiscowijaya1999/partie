import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partie/components/main_scaffold.dart';
import 'package:partie/utils/backup_archive.dart';

class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  bool _busy = false;
  String? _status;

  Future<void> _runBackup() async {
    setState(() {
      _busy = true;
      _status = 'Building archive...';
    });

    try {
      final bytes = await BackupArchive.buildBackupZip();

      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .split('.')
          .first;
      final suggestedName = 'partie_backup_$timestamp.zip';

      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save backup',
        fileName: suggestedName,
        type: FileType.custom,
        allowedExtensions: ['zip'],
        bytes: bytes,
      );

      if (!mounted) return;

      if (savePath == null) {
        setState(() => _status = 'Backup cancelled.');
        return;
      }

      // On mobile platforms file_picker writes via the `bytes` arg above.
      // On desktop it returns the chosen path and expects us to write.
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        await File(savePath).writeAsBytes(bytes, flush: true);
      }

      setState(() => _status = 'Backup saved.');
    } catch (e) {
      if (mounted) setState(() => _status = 'Backup failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _confirmRestore() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Restore backup?'),
            content: const Text(
              'This will replace ALL current vehicles, parts, items, and '
              'images with the contents of the chosen backup. The app will '
              'close after the restore so you can reopen it.\n\n'
              'This cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Restore'),
              ),
            ],
          ),
    );

    return confirmed ?? false;
  }

  Future<void> _runRestore() async {
    final picked = await FilePicker.platform.pickFiles(
      dialogTitle: 'Pick backup .zip',
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );

    if (picked == null || picked.files.single.path == null) return;
    final zipFile = File(picked.files.single.path!);

    if (!await _confirmRestore()) return;

    setState(() {
      _busy = true;
      _status = 'Restoring...';
    });

    try {
      await BackupArchive.restoreFromZip(zipFile);

      if (!mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => AlertDialog(
              title: const Text('Restore complete'),
              content: const Text(
                'The app will now close. Please reopen it to use the '
                'restored data.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Exit'),
                ),
              ],
            ),
      );
      await SystemNavigator.pop();
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _status = 'Restore failed: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Backup & Restore',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: _busy ? null : _runBackup,
                icon: const Icon(Icons.archive),
                label: const Text('Backup'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _busy ? null : _runRestore,
                icon: const Icon(Icons.restore),
                label: const Text('Restore'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 30),
              if (_busy) const CircularProgressIndicator(),
              if (_status != null) ...[
                const SizedBox(height: 10),
                Text(_status!, textAlign: TextAlign.center),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
