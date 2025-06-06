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
  
  static Future<void> updatePart(int partId, String name, String description) async {
    await db.managers.parts
      .filter((f) => f.id.equals(partId))
      .update((p) => p(name: Value(name), description: Value(description)));
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

  static Future<void> duplicatePartForVehicle(int partId, int vehicleId) async {
    return db.transaction(() async {
      final part = await db.managers.parts.filter((f) => f.id.equals(partId)).getSingle();
      final created = await db.managers.parts.create((p) => p(name: part.name, description: part.description));
      await db.managers.partVehicles.create((pv) => pv(partId: created, vehicleId: vehicleId));
    });
  }

  static Future<void> deletePart(int partId) async {
    return db.transaction(() async {
      await db.managers.parts.filter((f) => f.id.equals(partId)).delete();
    });
  }

  static Future<void> unlinkPart(int partId, int vehicleId) async {
    return db.transaction(() async {
      await db.managers.partVehicles.filter((f) => f.partId.id.equals(partId) & f.vehicleId.id.equals(vehicleId)).delete();
      final linkCount = await db.managers.partVehicles.filter((f) => f.partId.id.equals(partId)).count();

      if (linkCount == 0) {
        await db.managers.parts.filter((f) => f.id.equals(partId)).delete();
      }
    });
  }

  static Stream<Part> getPartDetailStream(int id) {
    return db.managers.parts.filter((part) => part.id.equals(id)).watchSingle();
  }

  static Future<List<PartChild>> getPartChildren(int id) async {
    return await db.transaction(() async {
      final parts = await db.managers.parts.filter((part) => part.parentId.id.equals(id)).get();
      final items = await db.managers.partItems
        .withReferences(
          (prefetch) => prefetch(itemId: true)
        )
        .filter((item) => item.partId.id.equals(id)).get();

      final children = [
        ...items.map((i) => PartChild(
          partId: id,
          itemId: i.$2.itemId.prefetchedData?.firstOrNull?.id,
          name: i.$2.itemId.prefetchedData?.firstOrNull?.name ?? 'unable to get name',
          qty: i.$1.qty,
          description: i.$1.description,
          isCategory: false
        )),
        ...parts.map((p) => PartChild(partId: p.id, isCategory: true, name: p.name))
      ];

      children.sort((a, b) => a.name.compareTo(b.name));

      return children;
    });
  }
}