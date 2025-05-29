import 'package:drift/drift.dart';
import 'package:partie/tables/parts.dart';
import 'package:partie/tables/vehicles.dart';

class PartVehicles extends Table {
  IntColumn get partId => integer().references(Parts, #id, onDelete: KeyAction.cascade)();
  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {partId, vehicleId}
  ];
}