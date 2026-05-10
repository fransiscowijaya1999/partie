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

@DriftDatabase(
  tables: [
    Vehicles,
    Items,
    Parts,
    PartItems,
    PartVehicles,
    InheritedPartReplacements,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          final schema = Schema2(database: migrator.database);
          final m = Migrator(migrator.database, schema);
          await m.createTable(schema.vehicles);
        }
        if (from < 3) {
          final schema = Schema3(database: migrator.database);
          final m = Migrator(migrator.database, schema);
          await m.alterTable(TableMigration(schema.vehicles));
          await m.createTable(schema.items);
          await m.createTable(schema.parts);
          await m.createTable(schema.partItems);
          await m.createTable(schema.partVehicles);
          await m.createTable(schema.inheritedPartReplacements);
        }
        if (from < 4) {
          final schema = Schema4(database: migrator.database);
          final m = Migrator(migrator.database, schema);
          await m.addColumn(schema.partItems, schema.partItems.topCoordinate);
          await m.addColumn(schema.partItems, schema.partItems.leftCoordinate);
          await m.addColumn(schema.parts, schema.parts.catalogImagePath);
        }
        if (from < 5) {
          await migrator.database.customStatement(
            'CREATE TABLE part_items_new ('
            'part_id INTEGER NOT NULL REFERENCES parts(id) ON DELETE CASCADE, '
            'item_id INTEGER NOT NULL REFERENCES items(id), '
            'top_coordinate REAL, '
            'left_coordinate REAL, '
            'qty TEXT NOT NULL, '
            'description TEXT NOT NULL, '
            'PRIMARY KEY (part_id, item_id))',
          );
          await migrator.database.customStatement(
            'INSERT INTO part_items_new '
            '(part_id, item_id, top_coordinate, left_coordinate, qty, description) '
            'SELECT part_id, item_id, top_coordinate, left_coordinate, qty, description '
            'FROM part_items',
          );
          await migrator.database.customStatement('DROP TABLE part_items');
          await migrator.database.customStatement(
            'ALTER TABLE part_items_new RENAME TO part_items',
          );
        }
        if (from < 6) {
          await migrator.database.customStatement(
            'CREATE TABLE part_items_new ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'part_id INTEGER NOT NULL REFERENCES parts(id) ON DELETE CASCADE, '
            'item_id INTEGER NOT NULL REFERENCES items(id), '
            'top_coordinate REAL, '
            'left_coordinate REAL, '
            'qty TEXT NOT NULL, '
            'description TEXT NOT NULL)',
          );
          await migrator.database.customStatement(
            'INSERT INTO part_items_new '
            '(part_id, item_id, top_coordinate, left_coordinate, qty, description) '
            'SELECT part_id, item_id, top_coordinate, left_coordinate, qty, description '
            'FROM part_items',
          );
          await migrator.database.customStatement('DROP TABLE part_items');
          await migrator.database.customStatement(
            'ALTER TABLE part_items_new RENAME TO part_items',
          );
        }
        if (from < 7) {
          final schema = Schema7(database: migrator.database);
          final m = Migrator(migrator.database, schema);
          await m.addColumn(schema.items, schema.items.image);
        }
      },
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
