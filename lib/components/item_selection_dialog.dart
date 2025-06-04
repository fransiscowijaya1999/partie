import 'package:flutter/material.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';

class ItemSelectionDialog extends StatefulWidget {
  const ItemSelectionDialog({
    super.key,
    required this.onSelected
  });

  final ValueSetter<Item> onSelected;

  @override
  State<ItemSelectionDialog> createState() => _ItemSelectionDialogState();
}

class _ItemSelectionDialogState extends State<ItemSelectionDialog> {
  final queryController = TextEditingController();

  late Future<List<Item>> _future;

  @override
  void initState() {
    super.initState();
    _future = ItemRepository.filter(name: queryController.text);

    queryController.addListener(() {
      setState(() {
        _future = ItemRepository.filter(name: queryController.text);
      });
    });
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select Item'),
      children: [
        TextField(
          controller: queryController,
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 300,
          width: 300,
          child: FutureBuilder(future: _future, builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final items = snapshot.data!;
          
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item.name),
                          onTap: () {
                            widget.onSelected(item);
                            Navigator.pop(context);
                          },
                        );        
                      },
                  );
                } else {
                  return Text('Data not set');
                }
            }
          },),
        )
      ],
    );
  }
}