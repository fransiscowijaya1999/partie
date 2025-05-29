import 'package:drift/drift.dart';
import 'package:partie/tables/items.dart';
import 'package:partie/tables/parts.dart';

class PartItems extends Table {
  IntColumn get partId => integer().references(Parts, #id, onDelete: KeyAction.cascade)();
  IntColumn get itemId => integer().references(Items, #id)();
  TextColumn get qty => text()();
  TextColumn get description => text()();
}