import 'package:flutter/material.dart';
import 'package:partie/database.dart';
import 'package:partie/screens/item_detail_screen.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    this.items
  });

  final List<Item>? items;

  @override
  Widget build(BuildContext context) {
    if (items == null) {
      return Center(child: Text('Items not set'),);
    } else if (items!.isEmpty) {
      return Center(child: Text('Items not found'),);
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: items!.length,
        itemBuilder: (context, index) {
          final item = items![index];

          return ListTile(
            title: Text(item.name),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ItemDetailScreen(
                  item: item,
                )),
              );
            },
          );
        },
      );    
    }
  }
}