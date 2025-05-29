import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:partie/database.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Text(widget.item.name),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: widget.item.description.isEmpty ?
                Center(child: Text('No description yet.'),) :
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: MarkdownBlock(data: widget.item.description),
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