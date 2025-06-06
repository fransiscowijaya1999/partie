import 'package:drift/drift.dart';
import 'package:partie/database.dart';

class ItemListStream {
  const ItemListStream(
    this.items,
    this.count
  );

  final Stream<List<Item>> items;
  final Stream<int> count;
}

class ItemRepository {
  static Future<List<Item>> filter({ String name = '', int limit = 10 }) async {

    List<Item> items = await db.managers.items
      .filter((f) => f.name.contains(name, caseInsensitive: true))
      .get(limit: limit);

    return items;
  }

  static ItemListStream filterWithAggregateWatch({ String name = '', int limit = 10, int page = 0, int? ignoredId }) {
    var query = db.managers.items
      .filter((f) => f.name.contains(name, caseInsensitive: true));

    final count = query
      .count().asStream();

    final items = query.watch(limit: limit, offset: page * limit);

    return ItemListStream(items, count);
  }

  static Stream<List<Item>> filterWatch() {
    return db.managers.items.watch();
  }

  static Future<void> createItem(String name, String description) async {
    await db.managers.items.create((o) => o(name: name, description: description));
  }

  static Future<void> deleteItem(int id) async {
    await db.managers.items.filter((f) => f.id.equals(id)).delete();
  }

  static Future<void> updateItem(int id, String name, String description) async {
    await db.managers.items.filter((f) => f.id.equals(id))
      .update((f) => f(name: Value(name), description: Value(description)));
  }
}