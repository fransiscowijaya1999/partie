import 'package:drift/drift.dart';

class Parts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get catalogImagePath => text().nullable()();
  IntColumn get parentId =>
      integer().nullable().references(
        Parts,
        #id,
        onDelete: KeyAction.cascade,
      )();
}
