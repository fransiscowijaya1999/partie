import 'package:drift/drift.dart';
import 'package:partie/database.dart';

class ItemRepository {
  static Future<List<Item>> filter({ String name = '', int limit = 10 }) async {

    List<Item> items = await db.managers.items
      .filter((f) => f.name.contains(name, caseInsensitive: true))
      .get(limit: limit);

    return items;
  }

  static Stream<List<Item>> filterWatch() {
    return db.managers.items.watch();
  }

  static Future<void> createItem(String name, String description) async {
    await db.managers.items.create((o) => o(name: name, description: description));
  }
}