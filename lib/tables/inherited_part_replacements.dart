import 'package:drift/drift.dart';
import 'package:partie/tables/parts.dart';
import 'package:partie/tables/vehicles.dart';

class InheritedPartReplacements extends Table {
  IntColumn get vehicleId => integer().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  IntColumn get inheritedPartId => integer().nullable().references(Parts, #id, onDelete: KeyAction.setNull)();
  IntColumn get replacementPartId => integer().references(Parts, #id, onDelete: KeyAction.cascade)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {vehicleId, inheritedPartId}
  ];
}