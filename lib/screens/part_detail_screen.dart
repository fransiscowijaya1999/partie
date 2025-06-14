import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:partie/components/part_children.dart';
import 'package:partie/components/part_create_dialog.dart';
import 'package:partie/components/part_item_create_dialog.dart';
import 'package:partie/database.dart';
import 'package:partie/models/part_child.dart';
import 'package:partie/repositories/part.dart';
import 'package:partie/utils/string_builder.dart';

class PartDetailScreen extends StatefulWidget {
  const PartDetailScreen({
    super.key,
    required this.title,
    required this.parentId,
    required this.partId,
    this.isVehiclePart = true,
  });

  final String title;
  final int parentId;
  final int partId;
  final bool isVehiclePart;

  @override
  State<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends State<PartDetailScreen> {
  late String title;
  late Stream<Part> _partStream;
  late Future<List<PartChild>> _partChildrenFuture;

  Future<void> _showCreatePartDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return PartCreateDialog(
          onCreate: (name, description) async {
            await PartRepository.createPartForPart(
              widget.partId,
              name,
              description,
            );
            setState(() {
              _partStream = PartRepository.getPartDetailStream(widget.partId);
              _partChildrenFuture = PartRepository.getPartChildren(
                widget.partId,
              );
            });
          },
        );
      },
    );
  }

  Future<void> _showEditPartDialog(
    String initName,
    String initDescription,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return PartCreateDialog(
          title: 'Edit: $initName',
          buttonText: 'Update',
          name: initName,
          description: initDescription,
          onCreate: (name, description) async {
            await PartRepository.updatePart(widget.partId, name, description);

            final seperated = title.split(" \\ ");
            seperated.removeLast();

            setState(() {
              title = StringBuilder.titleBuilder(seperated.join(" \\ "), name);
              _partStream = PartRepository.getPartDetailStream(widget.partId);
              _partChildrenFuture = PartRepository.getPartChildren(
                widget.partId,
              );
            });
          },
        );
      },
    );
  }

  Future<void> _showAssignItemDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return PartItemCreateDialog(
          onCreate: (itemId, qty, description) async {
            await PartRepository.assignItemToPart(
              widget.partId,
              itemId,
              qty,
              description,
            );
            setState(() {
              _partStream = PartRepository.getPartDetailStream(widget.partId);
              _partChildrenFuture = PartRepository.getPartChildren(
                widget.partId,
              );
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    title = widget.title;
    _partStream = PartRepository.getPartDetailStream(widget.partId);
    _partChildrenFuture = PartRepository.getPartChildren(widget.partId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: TextStyle(fontSize: 12))),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: _showAssignItemDialog,
            child: Icon(Icons.settings),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: _showCreatePartDialog,
            child: Icon(Icons.category),
          ),
        ],
      ),
      body: StreamBuilder<Part>(
        stream: _partStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final part = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(part.name, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )),
                      part.description.isNotEmpty
                          ? Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 250,
                                    child: Card(
                                      color: Colors.white,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: MarkdownBlock(
                                            data: part.description,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                          : SizedBox(height: 10),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    () => _showEditPartDialog(
                                      part.name,
                                      part.description,
                                    ),
                                child: Icon(Icons.edit),
                              ),
                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(
                              onPressed: () async {
                                if (widget.isVehiclePart) {
                                  await PartRepository.unlinkPart(
                                    part.id,
                                    widget.parentId,
                                  );
                                } else {
                                  await PartRepository.deletePart(part.id);
                                }
                        
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 10),
                      FutureBuilder(
                        future: _partChildrenFuture,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                return PartChildren(
                                  title: widget.title,
                                  children: snapshot.data!,
                                  parentId: widget.partId,
                                  onPop: () {
                                    setState(() {
                                      _partChildrenFuture =
                                          PartRepository.getPartChildren(
                                            widget.partId,
                                          );
                                    });
                                  },
                                  onItemDelete: (id) async {
                                    await PartRepository.deleteItemFromPart(
                                      widget.partId,
                                      id,
                                    );

                                    setState(() {
                                      _partChildrenFuture =
                                          PartRepository.getPartChildren(
                                            widget.partId,
                                          );
                                    });
                                  },
                                  onItemUpdated: (
                                    itemId,
                                    newItemId,
                                    qty,
                                    description,
                                  ) async {
                                    await PartRepository.updatePartItem(
                                      widget.partId,
                                      itemId,
                                      newItemId,
                                      qty,
                                      description,
                                    );

                                    setState(() {
                                      _partChildrenFuture =
                                          PartRepository.getPartChildren(
                                            widget.partId,
                                          );
                                    });
                                  },
                                );
                              } else {
                                return Text('Data not set');
                              }
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('Part not set'));
              }
          }
        },
      ),
    );
  }
}
