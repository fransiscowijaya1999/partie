import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:partie/components/delete_confirmation_dialog.dart';
import 'package:partie/components/item_links_dialog.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';
import 'package:partie/screens/item_edit_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({
    super.key,
    required this.item
  });

  final Item item;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late Item item;

  @override void initState() {
    item = widget.item;
    super.initState();
  }

  Future<void> _showRelation() async {
    await showDialog(
      context: context,
      builder: (context) => ItemLinksDialog(itemId: widget.item.id, title: widget.item.name,));
  }

  Future<void> _editItem() async {
    final Item updated = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ItemEditScreen(
        id: widget.item.id,
        name: widget.item.name,
        description: widget.item.description
      )),
    );

    setState(() {
      item = updated;
    });
  }

  Future<void> _deleteItem() async {
    final confirm = await showDialog(context: context, builder: (context) => DeleteConfirmationDialog()) ?? false;

    if (confirm) {
      await ItemRepository.deleteItem(widget.item.id);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Text(item.name),
            ),
            Padding(padding: EdgeInsets.all(10), child: Row(
              children: [
                ElevatedButton(
                  onPressed: _showRelation,
                  child: Icon(Icons.link)
                ),
                SizedBox(width: 10,),
                Expanded(child: ElevatedButton(
                  onPressed: _editItem,
                  child: Icon(Icons.edit)
                )),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: _deleteItem,
                  child: Icon(Icons.delete)
                )
              ],
            ),),
            SizedBox(height: 10,),
            Expanded(
              child: item.description.isEmpty ?
                Center(child: Text('No description yet.'),) :
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: MarkdownBlock(data: item.description),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );   
  }
}