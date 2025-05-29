import 'package:flutter/material.dart';
import 'package:partie/components/item_list.dart';
import 'package:partie/components/main_scaffold.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';
import 'package:partie/screens/item_create_screen.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({
    super.key,
  });

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  late Stream<List<Item>> _itemsStream;

  @override
  void initState() {
    super.initState();

    _itemsStream = ItemRepository.filterWatch();
  }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Items',
      body: StreamBuilder<List<Item>>(
        stream: _itemsStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ItemList(items: snapshot.data);
              } else {
                return ItemList(items: []);
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ItemCreateScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}