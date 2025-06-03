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

  static Future<void> createVehicle(String name, String description, { int? parentId }) async {
    await db.managers.vehicles.create((v) => v(name: name, description: description));
  }

  static Future<Vehicle?>getVehicle(int id) async {
    return await db.managers.vehicles.filter((f) => f.id.equals(id)).getSingleOrNull();
  }

  static Stream<List<Part>> searchPartWatch(int vehicleId, { int? parentId, String name = '', int limit = 0 }) {
    // final tsx = db.transaction(() async {
    //   final ignoredParts = await db.managers.inheritedPartReplacements
    //     .filter((f) => f.vehicleId.id.equals(vehicleId) & f.inheritedPartId.id.isNotNull())
    //     .map((row) => row.inheritedPartId!)
    //     .get();

    //     return ignoredParts;
    // });

    // var query = db.select(db.parts).join([
    //     // leftOuterJoin(db.inheritedPartReplacements, db.partVehicles.partId.equalsExp(db.parts.id), useColumns: false),
    //     innerJoin(db.partVehicles, db.partVehicles.partId.equalsExp(db.parts.id), useColumns: false),
    //   ])
    //     ..where(Expression.or([
    //       db.partVehicles.vehicleId.equals(vehicleId),
    //       parentId != null ?
    //         Expression.and([
    //           db.partVehicles.vehicleId.equals(parentId),
    //           // db.inheritedPartReplacements.vehicleId.equals(vehicleId),
    //         ])
    //         : db.partVehicles.vehicleId.equals(vehicleId)
    //     ]))
    //     ..where(db.parts.name.containsCase(name, caseSensitive: false))
    //     ..orderBy([
    //       OrderingTerm.asc(db.parts.name)
    //     ]);

    // return query.map((row) => row.readTable(db.parts)).watch();

    return db.customSelect(
      'SELECT parts.id, parts.name, parts.description FROM parts'
      ' INNER JOIN part_vehicles ON part_vehicles.part_id = parts.id'
      ' LEFT JOIN inherited_part_replacements ON inherited_part_replacements.replacement_part_id = parts.id'
      ' WHERE part_vehicles.vehicle_id = ?'
      ' ${parentId != null ? 'OR part_vehicles.vehicle_id = $parentId' : ''}'
      ' ${parentId != null ? 'AND inherited_part_replacements.vehicle_id = $vehicleId AND parts.id NOT IN (SELECT inherited_part_id FROM inherited_part_replacements WHERE vehicle_id = $vehicleId)' : ''}',
      variables: [
        Variable.withInt(vehicleId)
      ]
    ).watch().map((rows) {
      return rows.map((row) => db.parts.map(row.data)).toList();
    });
  }
}