import 'package:drift/drift.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/part.dart';

class VehicleListStream {
  const VehicleListStream(
    this.vehicles,
    this.count
  );

  final Stream<List<Vehicle>> vehicles;
  final Stream<int> count;
}

class VehicleRepository {
  static Future<List<Vehicle>> filter({ String name = '', int limit = 10, int? ignoredId }) async {
    var query = db.managers.vehicles
      .filter((f) => f.name.contains(name, caseInsensitive: true));
    
    if (ignoredId != null) {
      query = query.filter((f) => f.id.not(ignoredId));
    }

    List<Vehicle> vehicles = await query.get(limit: limit);

    return vehicles;
  }

  static Stream<List<Vehicle>> filterWatch({ String name = '', int limit = 10, int? ignoredId }) {
    var query = db.managers.vehicles
      .filter((f) => f.name.contains(name, caseInsensitive: true));

    return query.watch(limit: limit);
  }

  static VehicleListStream filterWithAggregateWatch({ String name = '', int limit = 10, int page = 0, int? ignoredId }) {
    var query = db.managers.vehicles
      .filter((f) => f.name.contains(name, caseInsensitive: true));

    final count = query
      .count().asStream();

    final vehicles = query.watch(limit: limit, offset: page * limit);

    return VehicleListStream(vehicles, count);
  }

  static Future<void> createVehicle(String name, String description, { int? parentId }) async {
    await db.managers.vehicles.create((v) => v(name: name, description: description, parentId: Value(parentId)));
  }

  static Future<void> updateVehicle(int id, String name, String description, { int? parentId }) async {
    await db.managers.vehicles
      .filter((f) => f.id.equals(id))
      .update((v) => v(name: Value(name), description: Value(description), parentId: Value(parentId)));
  }

  static Future<void> deleteVehicle(int id) async {
    await db.transaction(() async {
      final partLinks = await db.managers.partVehicles
        .filter((f) => f.vehicleId.id.equals(id))
        .get();
      
      for (final link in partLinks) {
        await PartRepository.unlinkPart(link.partId, id);
      }

      await db.managers.vehicles
        .filter((f) => f.id.equals(id))
        .delete();
    });
  }

  static Future<Vehicle?>getVehicle(int id) async {
    return await db.managers.vehicles.filter((f) => f.id.equals(id)).getSingleOrNull();
  }
  static Future<Vehicle>getVehicleNotNull(int id) async {
    return await db.managers.vehicles.filter((f) => f.id.equals(id)).getSingle();
  }
  static Stream<Vehicle> getVehicleWatch(int id) {
    return db.managers.vehicles.filter((f) => f.id.equals(id)).watchSingle();
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
      ' ${parentId != null ? 'OR (part_vehicles.vehicle_id = $parentId' : ''}'
      ' ${parentId != null ? 'AND parts.id NOT IN (SELECT inherited_part_id FROM inherited_part_replacements WHERE vehicle_id = $vehicleId))' : ''}'
      ' ORDER BY parts.name',
      variables: [
        Variable.withInt(vehicleId)
      ]
    ).map((row) => db.parts.map(row.data)).watch();
  }

  static Future<List<Part>> searchPart(int vehicleId, { int? parentId, String name = '', int limit = 0 }) {
    return db.customSelect(
      'SELECT parts.id, parts.name, parts.description FROM parts'
      ' INNER JOIN part_vehicles ON part_vehicles.part_id = parts.id'
      ' LEFT JOIN inherited_part_replacements ON inherited_part_replacements.replacement_part_id = parts.id'
      ' WHERE part_vehicles.vehicle_id = ?'
      ' ${parentId != null ? 'OR (part_vehicles.vehicle_id = $parentId' : ''}'
      ' ${parentId != null ? 'AND parts.id NOT IN (SELECT inherited_part_id FROM inherited_part_replacements WHERE vehicle_id = $vehicleId))' : ''}'
      ' ORDER BY parts.name',
      variables: [
        Variable.withInt(vehicleId)
      ]
    ).map((row) => db.parts.map(row.data)).get();
  }
}