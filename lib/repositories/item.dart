import 'package:drift/drift.dart';
import 'package:partie/database.dart';
import 'package:partie/utils/search_query.dart';
import 'package:partie/utils/string_builder.dart';

class PartItemData {
  const PartItemData({required this.partId, this.description = ''});

  final int partId;
  final String description;
}

class ItemPath {
  const ItemPath({this.path = '', this.description = ''});

  final String path;
  final String description;
}

class ItemListStream {
  const ItemListStream(this.items, this.count);

  final Stream<List<Item>> items;
  final Stream<int> count;
}

class ItemRepository {
  static Future<List<Item>> filter({
    String name = '',
    int limit = 10,
    int? ignoredId,
  }) async {
    final tokens = SearchQuery.tokenize(name);
    var query = db.managers.items.filter((f) => f.id.not(ignoredId));
    for (final token in tokens) {
      query = query.filter(
        (f) => f.name.contains(token, caseInsensitive: true),
      );
    }

    return await query.get(limit: limit);
  }

  static ItemListStream filterWithAggregateWatch({
    String name = '',
    int limit = 10,
    int page = 0,
    int? ignoredId,
  }) {
    final tokens = SearchQuery.tokenize(name);
    var query = db.managers.items.filter(
      (f) => f.name.contains('', caseInsensitive: true),
    );
    for (final token in tokens) {
      query = query.filter(
        (f) => f.name.contains(token, caseInsensitive: true),
      );
    }

    final countExp = db.items.id.count();
    final countQuery = db.selectOnly(db.items)..addColumns([countExp]);
    for (final token in tokens) {
      countQuery.where(db.items.name.lower().like('%${token.toLowerCase()}%'));
    }
    final count = countQuery.map((row) => row.read(countExp)!).watchSingle();

    final items = query.watch(limit: limit, offset: page * limit);

    return ItemListStream(items, count);
  }

  static Stream<List<Item>> filterWatch() {
    return db.managers.items.watch();
  }

  static Future<int> createItem(
    String name,
    String description, {
    Value<Uint8List?> image = const Value.absent(),
  }) async {
    return await db.managers.items.create(
      (o) => o(name: name, description: description, image: image),
    );
  }

  static Future<void> deleteItem(int id) async {
    await db.managers.items.filter((f) => f.id.equals(id)).delete();
  }

  static Future<void> updateItem(
    int id,
    String name,
    String description, {
    Value<Uint8List?> image = const Value.absent(),
  }) async {
    await db.managers.items
        .filter((f) => f.id.equals(id))
        .update(
          (f) => f(
            name: Value(name),
            description: Value(description),
            image: image,
          ),
        );
  }

  static Future<List<String>> _getPartPath(int id) async {
    return await db.transaction(() async {
      final part =
          await db.managers.parts.filter((f) => f.id.equals(id)).getSingle();

      if (part.parentId != null) {
        final basePaths = await _getPartPath(part.parentId!);

        return basePaths
            .map((path) => StringBuilder.titleBuilder(path, part.name))
            .toList();
      } else {
        final partVehicles =
            await db.managers.partVehicles
                .withReferences((prefetch) => prefetch(vehicleId: true))
                .filter((f) => f.partId.id.equals(id))
                .map((row) => row.$2.vehicleId.prefetchedData!.first.name)
                .get();

        return partVehicles
            .map((name) => StringBuilder.titleBuilder(name, part.name))
            .toList();
      }
    });
  }

  static Future<List<ItemPath>> getItemLinkedPart(int id) async {
    final parts =
        await db.managers.partItems.filter((f) => f.itemId.id.equals(id)).get();

    final List<ItemPath> paths = [];

    await Future.forEach(parts, (part) async {
      final partId = part.partId;
      final partDescription = part.description;

      final pathList = await _getPartPath(partId);

      for (final path in pathList) {
        final toAdd = ItemPath(path: path, description: partDescription);

        paths.add(toAdd);
      }
    });

    return paths;
  }
}
