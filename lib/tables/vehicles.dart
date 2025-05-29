import 'package:drift/drift.dart';

class Vehicles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get parentId => integer().nullable().references(Vehicles, #id)();
}