import 'package:drift/drift.dart';
import 'package:partie/database.dart';
import 'package:partie/utils/string_builder.dart';

class PartItemData {
  const PartItemData({
    required this.partId,
    required this.vehicleId,
    this.description = ''
  });

  final int partId;
  final int vehicleId;
  final String description;
}

class ItemPath {
  const ItemPath({
    this.path = '',
    this.description = ''
  });

  final String path;
  final String description;
}

class ItemListStream {
  const ItemListStream(
    this.items,
    this.count
  );

  final Stream<List<Item>> items;
  final Stream<int> count;
}

class ItemRepository {
  static Future<List<Item>> filter({ String name = '', int limit = 10 }) async {

    List<Item> items = await db.managers.items
      .filter((f) => f.name.contains(name, caseInsensitive: true))
      .get(limit: limit);

    return items;
  }

  static ItemListStream filterWithAggregateWatch({ String name = '', int limit = 10, int page = 0, int? ignoredId }) {
    var query = db.managers.items
      .filter((f) => f.name.contains(name, caseInsensitive: true));

    final count = query
      .count().asStream();

    final items = query.watch(limit: limit, offset: page * limit);

    return ItemListStream(items, count);
  }

  static Stream<List<Item>> filterWatch() {
    return db.managers.items.watch();
  }

  static Future<int> createItem(String name, String description) async {
    return await db.managers.items.create((o) => o(name: name, description: description));
  }

  static Future<void> deleteItem(int id) async {
    await db.managers.items.filter((f) => f.id.equals(id)).delete();
  }

  static Future<void> updateItem(int id, String name, String description) async {
    await db.managers.items.filter((f) => f.id.equals(id))
      .update((f) => f(name: Value(name), description: Value(description)));
  }

  static Future<String> _getPartPath(int id) async {
    return await db.transaction(() async {
      print('pret');
      final part = await db.managers.parts.filter((f) => f.id.equals(id)).getSingle();

      if (part.parentId != null) {
        final basePath = await _getPartPath(part.parentId!);

        return StringBuilder.titleBuilder(basePath, part.name);
      } else {
        print(await db.managers.partVehicles
          .withReferences(
            (prefetch) => prefetch(vehicleId: true)
          )
          .filter((f) => f.partId.id.equals(part.id)).get());
        final partVehicle = await db.managers.partVehicles
          .withReferences(
            (prefetch) => prefetch(vehicleId: true)
          )
          .filter((f) => f.partId.id.equals(part.id)).getSingle();
        
        return StringBuilder.titleBuilder(partVehicle.$2.vehicleId.prefetchedData!.first.name, part.name);
      }
    });
  }

  static Future<List<ItemPath>> getItemLinkedPart(int id) async {
    // final sql =
    //   'SELECT parts.id, part_vehicles.vehicle_id, part_items.description FROM parts'
    //   ' CROSS JOIN part_items ON part_items.part_id = parts.id'
    //   ' CROSS JOIN part_vehicles ON part_vehicles.part_id = parts.id'
    //   ' WHERE part_vehicles.part_id IN (SELECT part_id FROM part_items WHERE item_id = ?)'
    //   ' OR part_vehicles.part_id IN (SELECT part_id FROM part_items WHERE item_id = ?)'
    // ;

    final sql =
      'SELECT parts.id, part_items.description FROM parts'
      ' INNER JOIN part_items ON part_items.part_id = parts.id'
      ' LEFT JOIN part_vehicles ON part_vehicles.part_id = parts.id'
      ' WHERE part_items.part_id IN (SELECT part_id FROM part_items WHERE item_id = ?)'
    ;

    return await db.transaction(() async {
      final parts = await db.customSelect(sql, variables: [
          Variable.withInt(id),
          // Variable.withInt(id),
        ])
        .map((row) {
          print(row.data['id']);

          return row.data['id'];
          // return PartItemData(
          //   partId: row.data['id'],
          //   vehicleId: row.data['vehicle_id'],
          //   description: row.data['description']
          // );
        })
        .get();

      final List<ItemPath> paths = [];

      await Future.forEach(parts, (part) async {
        final partId = part.partId;
        final partDescription = part.description;

        final path = await _getPartPath(partId);
        print('safe');
        final toAdd = ItemPath(
          path: path,
          description: partDescription
        );

        paths.add(toAdd);
      });

      return paths;
    });
  }
}