import 'package:flutter/material.dart';
import 'package:partie/repositories/item.dart';

class ItemLinksDialog extends StatelessWidget {
  const ItemLinksDialog({
    super.key,
    required this.itemId,
    this.title = 'Used in',
  });

  final String title;
  final int itemId;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title, style: TextStyle(fontSize: 15)),
      children: [
        Divider(height: 2),
        FutureBuilder<List<ItemPath>>(
          future: ItemRepository.getItemLinkedPart(itemId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final paths = snapshot.data!;

                  return SizedBox(
                    height: 300,
                    width: 250,
                    child: ListView.separated(
                      itemCount: paths.length,
                      itemBuilder: (context, index) {
                        final path = paths[index];

                        return ListTile(
                          title: Text(
                            path.path,
                            style: TextStyle(fontSize: 11),
                          ),
                          dense: true,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 2);
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('Unable to load data'));
                }
            }
          },
        ),
      ],
    );
  }
}
