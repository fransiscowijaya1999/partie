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
}