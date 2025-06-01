import 'package:drift/drift.dart';
import 'package:partie/database.dart';

class VehicleRepository {
  static Future<List<Vehicle>> filter({ String name = '', int limit = 10 }) async {

    List<Vehicle> vehicles = await db.managers.vehicles
      .filter((f) => f.name.contains(name, caseInsensitive: true))
      .get(limit: limit);

    return vehicles;
  }

  static Stream<List<Vehicle>> filterWatch() {
    return db.managers.vehicles.watch();
  }

  static Future<void> createVehicle(String name, String description) async {
    await db.managers.vehicles.create((v) => v(name: name, description: description));
  }

  static Stream<List<Part>> searchPartWatch(int vehicleId, { String name = '', int limit = 0 }) {
    final query = db.managers.parts
      .withReferences(
        (prefetch) => prefetch(partVehiclesRefs: true)
      )
      .filter((f) => f.partVehiclesRefs((pv) => pv.vehicleId.id.equals(vehicleId)))
      .orderBy((o) => o.name.asc());

    return query.map((row) => row.$1).watch();
  }
}