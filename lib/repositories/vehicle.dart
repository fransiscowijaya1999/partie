import 'package:partie/database.dart';

class VehicleRepository {
  static Future<List<Vehicle>> filter() async {
    List<Vehicle> vehicles = await db.managers.vehicles.get();

    return vehicles;
  }

  static Future<void> createVehicle(String name, String description) async {
    await db.managers.vehicles.create((v) => v(name: name, description: description));
  }
}