import 'package:partie/database.dart';

class PartRepository {
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

  static Stream<Part> getPartDetailStream(int id) {
    return db.managers.parts.filter((part) => part.id.equals(id)).watchSingle();
  }
}