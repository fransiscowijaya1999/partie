import 'package:flutter/material.dart';
import 'package:partie/repositories/item.dart';

class ItemLinksDialog extends StatefulWidget {
  const ItemLinksDialog({
    super.key,
    required this.itemId,
    this.title = 'Used in',
  });

  final String title;
  final int itemId;

  @override
  State<ItemLinksDialog> createState() => _ItemLinksDialogState();
}

class _ItemLinksDialogState extends State<ItemLinksDialog> {
  final Map<int, ExpansionTileController> _controllers = {};
  int? _expandedIndex;
  late final Future<List<ItemPath>> _pathsFuture;

  @override
  void initState() {
    super.initState();
    _pathsFuture = ItemRepository.getItemLinkedPart(widget.itemId);
  }

  ExpansionTileController _controllerFor(int index) {
    return _controllers.putIfAbsent(index, ExpansionTileController.new);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title, style: TextStyle(fontSize: 15)),
      children: [
        Divider(height: 2),
        FutureBuilder<List<ItemPath>>(
          future: _pathsFuture,
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

                        if (path.description.isEmpty) {
                          return ListTile(
                            title: Text(
                              path.path,
                              style: TextStyle(fontSize: 11),
                            ),
                            dense: true,
                          );
                        }

                        return ExpansionTile(
                          controller: _controllerFor(index),
                          title: Text(
                            path.path,
                            style: TextStyle(fontSize: 11),
                          ),
                          tilePadding: EdgeInsets.symmetric(horizontal: 16),
                          childrenPadding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          visualDensity: VisualDensity.compact,
                          onExpansionChanged: (expanded) {
                            if (expanded &&
                                _expandedIndex != null &&
                                _expandedIndex != index) {
                              _controllers[_expandedIndex!]?.collapse();
                            }
                            setState(() {
                              _expandedIndex = expanded ? index : null;
                            });
                          },
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                path.description,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
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
