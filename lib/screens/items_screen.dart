import 'package:flutter/material.dart';
import 'package:partie/components/item_list.dart';
import 'package:partie/components/main_scaffold.dart';
import 'package:partie/components/pagination.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';
import 'package:partie/screens/item_create_screen.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  int page = 0;
  int limit = 10;

  late ItemListStream _itemsStream;
  final queryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _itemsStream = ItemRepository.filterWithAggregateWatch(
      name: queryController.text,
      limit: 10,
      page: page,
    );

    queryController.addListener(() {
      setState(() {
        page = 0;

        _itemsStream = ItemRepository.filterWithAggregateWatch(
          name: queryController.text,
          limit: 10,
          page: page,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Items',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: queryController,
                    decoration: InputDecoration(label: Text('Search')),
                  ),
                ),
              ),
            ),
            StreamBuilder<List<Item>>(
              stream: _itemsStream.items,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
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
            StreamBuilder(
              stream: _itemsStream.count,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      final count = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Pagination(
                          page: page,
                          count: count,
                          limit: limit,
                          onMove: (step) {
                            setState(() {
                              page += step;
                              _itemsStream =
                                  ItemRepository.filterWithAggregateWatch(
                                    name: queryController.text,
                                    limit: 10,
                                    page: page,
                                  );
                            });
                          },
                        ),
                      );
                    } else {
                      return Text('Failed');
                    }
                }
              },
            ),
            SizedBox(height: 200),
          ],
        ),
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
