import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:partie/components/delete_confirmation_dialog.dart';
import 'package:partie/components/item_links_dialog.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';
import 'package:partie/screens/item_edit_screen.dart';

class ItemDetailScreenAsync extends StatefulWidget {
  const ItemDetailScreenAsync({super.key, required this.itemId});

  final int itemId;

  @override
  State<ItemDetailScreenAsync> createState() => _ItemDetailScreenAsyncState();
}

class _ItemDetailScreenAsyncState extends State<ItemDetailScreenAsync> {
  late Future<Item> _itemFuture;

  @override
  void initState() {
    _itemFuture =
        db.managers.items.filter((f) => f.id.equals(widget.itemId)).getSingle();
    super.initState();
  }

  Future<void> _showRelation(int id, String name) async {
    await showDialog(
      context: context,
      builder: (context) => ItemLinksDialog(itemId: id, title: name),
    );
  }

  Future<void> _editItem(Item item) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (context) => ItemEditScreen(
              id: item.id,
              name: item.name,
              description: item.description,
            ),
      ),
    );

    setState(() {
      _itemFuture =
          db.managers.items
              .filter((f) => f.id.equals(widget.itemId))
              .getSingle();
    });
  }

  Future<void> _deleteItem(int id) async {
    final confirm =
        await showDialog(
          context: context,
          builder: (context) => DeleteConfirmationDialog(),
        ) ??
        false;

    if (confirm) {
      await ItemRepository.deleteItem(id);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Item>(
      future: _itemFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              final item = snapshot.data!;
              return Scaffold(
                appBar: AppBar(title: Text(item.name)),
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Center(child: Text(item.name)),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed:
                                  () => _showRelation(item.id, item.name),
                              child: Icon(Icons.link),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _editItem(item),
                                child: Icon(Icons.edit),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () => _deleteItem(item.id),
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Expanded(
                        child:
                            item.description.isEmpty
                                ? Center(child: Text('No description yet.'))
                                : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SingleChildScrollView(
                                            child: MarkdownBlock(
                                              data: item.description,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(body: Center(child: Text('Data not set')));
            }
        }
      },
    );
  }
}
