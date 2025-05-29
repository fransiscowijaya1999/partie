import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:partie/database.steps.dart';
import 'package:partie/tables/inherited_part_replacements.dart';
import 'package:partie/tables/items.dart';
import 'package:partie/tables/part_items.dart';
import 'package:partie/tables/part_vehicles.dart';
import 'package:partie/tables/parts.dart';
import 'package:partie/tables/vehicles.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Vehicles,
  Items,
  Parts,
  PartItems,
  PartVehicles,
  InheritedPartReplacements
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

   @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.vehicles);
        },
        from2To3: (m, schema) async {
          await m.alterTable(TableMigration(schema.vehicles));
          await m.createTable(schema.items);
          await m.createTable(schema.parts);
          await m.createTable(schema.partItems);
          await m.createTable(schema.partVehicles);
          await m.createTable(schema.inheritedPartReplacements);
        }
      ),
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'partie_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

final db = AppDatabase();
