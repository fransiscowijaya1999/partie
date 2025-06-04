import 'package:drift/drift.dart';
import 'package:partie/database.dart';
import 'package:partie/models/part_child.dart';

class PartRepository {
  static Future<void> assignItemToPart(
    int partId,
    int itemId,
    String qty,
    String description
  ) async {
    return db.transaction(() async {
      await db.managers.partItems.create((f) => f(
        partId: partId,
        itemId: itemId,
        qty: qty,
        description: description
      ));
    });
  }

  static Future<void> createPartForVehicle(
    int vehicleId,
    String name,
    String description
  ) async {
    return db.transaction(() async {
      final created = await db.managers.parts.create((part) => part(name: name, description: description));
      await db.managers.partVehicles.create((pv) => pv(partId: created, vehicleId: vehicleId));
    });
  }

  static Future<void> createPartForPart(
    int partId,
    String name,
    String description
  ) async {
    return db.transaction(() async {
      await db.managers.parts.create((part) => part(name: name, description: description, parentId: Value(partId)));
    });
  }

  static Future<void> linkPartForVehicle(int partId, int vehicleId) async {
    return db.transaction(() async {
      await db.managers.partVehicles.create((pv) => pv(partId: partId, vehicleId: vehicleId));
    });
  }

  static Stream<Part> getPartDetailStream(int id) {
    return db.managers.parts.filter((part) => part.id.equals(id)).watchSingle();
  }

  static Future<List<PartChild>> getPartChildren(int id) async {
    return await db.transaction(() async {
      final parts = await db.managers.parts.filter((part) => part.parentId.id.equals(id)).get();
      final items = await db.managers.items
        .withReferences(
          (prefetch) => prefetch(partItemsRefs: true)
        )
        .filter((item) => item.partItemsRefs((f) => f.partId.id.equals(id))).get();

      final children = [
        ...items.map((i) => PartChild(id: i.$1.id, name: i.$1.name, isCategory: false)),
        ...parts.map((p) => PartChild(id: p.id, isCategory: true, name: p.name))
      ];

      children.sort((a, b) => a.name.compareTo(b.name));

      return children;
    });
  }
}