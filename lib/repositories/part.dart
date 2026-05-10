import 'dart:io';

import 'package:drift/drift.dart';
import 'package:partie/database.dart';
import 'package:partie/models/part_child.dart';

class PartRepository {
  static Future<void> assignItemToPart(
    int partId,
    int itemId,
    String qty,
    String description,
    double? topCoordinate,
    double? leftCoordinate,
  ) async {
    return db.transaction(() async {
      await db
          .into(db.partItems)
          .insertOnConflictUpdate(
            PartItemsCompanion(
              partId: Value(partId),
              itemId: Value(itemId),
              qty: Value(qty),
              description: Value(description),
              topCoordinate: Value(topCoordinate),
              leftCoordinate: Value(leftCoordinate),
            ),
          );
    });
  }

  static Future<void> createPartForVehicle(
    int vehicleId,
    String name,
    Value<String?> catalogImagePath,
    String description,
  ) async {
    return db.transaction(() async {
      final created = await db.managers.parts.create(
        (part) => part(
          name: name,
          catalogImagePath: catalogImagePath,
          description: description,
        ),
      );
      await db.managers.partVehicles.create(
        (pv) => pv(partId: created, vehicleId: vehicleId),
      );
    });
  }

  static Future<void> updatePart(
    int partId,
    String name,
    Value<String?> catalogImagePath,
    String description,
  ) async {
    final currentPart =
        await db.managers.parts.filter((f) => f.id.equals(partId)).getSingle();

    await db.managers.parts
        .filter((f) => f.id.equals(partId))
        .update(
          (p) => p(
            name: Value(name),
            description: Value(description),
            catalogImagePath: catalogImagePath,
          ),
        );

    final newPath =
        catalogImagePath.present
            ? catalogImagePath.value
            : currentPart.catalogImagePath;

    if (newPath != currentPart.catalogImagePath) {
      // Delete the old image file if it exists and is being replaced
      if (currentPart.catalogImagePath != null) {
        final oldFile = File(currentPart.catalogImagePath!);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }

      await db.managers.partItems
          .filter((f) => f.partId.id.equals(partId))
          .update(
            (pi) => pi(topCoordinate: Value(null), leftCoordinate: Value(null)),
          );
    }
  }

  static Future<void> createPartForPart(
    int partId,
    String name,
    Value<String?> catalogImagePath,
    String description,
  ) async {
    return db.transaction(() async {
      await db.managers.parts.create(
        (part) => part(
          name: name,
          catalogImagePath: catalogImagePath,
          description: description,
          parentId: Value(partId),
        ),
      );
    });
  }

  static Future<void> linkPartForVehicle(int partId, int vehicleId) async {
    return db.transaction(() async {
      await db.managers.partVehicles.create(
        (pv) => pv(partId: partId, vehicleId: vehicleId),
      );
    });
  }

  static Future<void> _duplicatePartChildren(int originId, int targetId) {
    return db.transaction(() async {
      final items =
          await db.managers.partItems
              .filter((f) => f.partId.id.equals(originId))
              .get();
      final parts =
          await db.managers.parts
              .filter((f) => f.parentId.id.equals(originId))
              .get();

      for (final item in items) {
        await db.managers.partItems.create(
          (f) => f(
            itemId: item.itemId,
            partId: targetId,
            qty: item.qty,
            description: item.description,
          ),
        );
      }

      for (final part in parts) {
        final created = await db.managers.parts.create(
          (f) => f(
            parentId: Value(targetId),
            catalogImagePath: Value(part.catalogImagePath),
            description: part.description,
            name: part.name,
          ),
        );
        await _duplicatePartChildren(part.id, created);
      }
    });
  }

  static Future<void> duplicatePartForVehicle(int partId, int vehicleId) async {
    return db.transaction(() async {
      final part =
          await db.managers.parts
              .filter((f) => f.id.equals(partId))
              .getSingle();
      final created = await db.managers.parts.create(
        (p) => p(
          name: part.name,
          catalogImagePath: Value(part.catalogImagePath),
          description: part.description,
        ),
      );

      await _duplicatePartChildren(partId, created);

      await db.managers.partVehicles.create(
        (pv) => pv(partId: created, vehicleId: vehicleId),
      );
    });
  }

  static Future<void> deletePart(int partId) async {
    return db.transaction(() async {
      await deletePartRelated(partId);
      final deleted =
          (await (db.delete(db.parts)
                ..where((f) => f.id.equals(partId))).goAndReturn())
              .first;

      if (deleted.catalogImagePath != null) {
        final file = File(deleted.catalogImagePath!);
        if (await file.exists()) {
          await file.delete();
        }
      }
    });
  }

  static Future<void> unlinkPart(int partId, int vehicleId) async {
    return db.transaction(() async {
      await db.managers.partVehicles
          .filter(
            (f) =>
                f.partId.id.equals(partId) & f.vehicleId.id.equals(vehicleId),
          )
          .delete();
      final linkCount =
          await db.managers.partVehicles
              .filter((f) => f.partId.id.equals(partId))
              .count();

      if (linkCount == 0) {
        await deletePartRelated(partId);
        final deleted =
            (await (db.delete(db.parts)
                  ..where((f) => f.id.equals(partId))).goAndReturn())
                .first;

        if (deleted.catalogImagePath != null) {
          final file = File(deleted.catalogImagePath!);
          if (await file.exists()) {
            await file.delete();
          }
        }
      }
    });
  }

  static Stream<Part> getPartDetailStream(int id) {
    return db.managers.parts.filter((part) => part.id.equals(id)).watchSingle();
  }

  static Future<void> deleteItemFromPart(int partId, int? partItemId) async {
    return db.transaction(() async {
      if (partItemId != null) {
        await db.managers.partItems
            .filter((f) => f.id.equals(partItemId))
            .delete();
      } else {
        await db.managers.partItems
            .filter((f) => f.partId.id.equals(partId) & f.itemId.id.isNull())
            .delete();
      }
    });
  }

  static Future<void> updatePartItem(
    int partItemId,
    int newItemId,
    String qty,
    String description,
    double? topCoordinate,
    double? leftCoordinate,
  ) async {
    await db.managers.partItems
        .filter((f) => f.id.equals(partItemId))
        .update(
          (f) => f(
            itemId: Value(newItemId),
            qty: Value(qty),
            description: Value(description),
            topCoordinate: Value(topCoordinate),
            leftCoordinate: Value(leftCoordinate),
          ),
        );
  }

  static Future<void> deletePartRelated(int partId) async {
    return await db.transaction(() async {
      await db.managers.partItems
          .filter((f) => f.partId.id.equals(partId))
          .delete();

      final childrenPart =
          await db.managers.parts
              .filter((f) => f.parentId.id.equals(partId))
              .get();

      for (final child in childrenPart) {
        await deletePartRelated(child.id);

        if (child.catalogImagePath != null) {
          final file = File(child.catalogImagePath!);
          if (await file.exists()) {
            await file.delete();
          }
        }

        await (db.delete(db.parts)
          ..where((f) => f.id.equals(child.id))).goAndReturn();
      }
    });
  }

  static Future<List<PartChild>> getPartChildren(int id) async {
    return await db.transaction(() async {
      final parts =
          await db.managers.parts
              .filter((part) => part.parentId.id.equals(id))
              .get();
      final items =
          await db.managers.partItems
              .withReferences((prefetch) => prefetch(itemId: true))
              .filter((item) => item.partId.id.equals(id))
              .get();

      final children = [
        ...items.map(
          (i) => PartChild(
            partId: id,
            itemId: i.$2.itemId.prefetchedData?.firstOrNull?.id,
            partItemId: i.$1.id,
            name:
                i.$2.itemId.prefetchedData?.firstOrNull?.name ??
                'unable to get name',
            qty: i.$1.qty,
            description: i.$1.description,
            isCategory: false,
            topCoordinate: i.$1.topCoordinate,
            leftCoordinate: i.$1.leftCoordinate,
            image: i.$2.itemId.prefetchedData?.firstOrNull?.image,
          ),
        ),
        ...parts.map(
          (p) => PartChild(partId: p.id, isCategory: true, name: p.name),
        ),
      ];

      children.sort((a, b) => a.name.compareTo(b.name));

      return children;
    });
  }
}
