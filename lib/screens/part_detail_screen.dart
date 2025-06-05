import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:partie/components/part_children.dart';
import 'package:partie/components/part_create_dialog.dart';
import 'package:partie/components/part_item_create_dialog.dart';
import 'package:partie/database.dart';
import 'package:partie/models/part_child.dart';
import 'package:partie/repositories/part.dart';

class PartDetailScreen extends StatefulWidget {
  const PartDetailScreen({
    super.key,
    required this.title,
    required this.parentId,
    required this.partId,
    this.isVehiclePart = true
  });

  final String title;
  final int parentId;
  final int partId;
  final bool isVehiclePart;

  @override
  State<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends State<PartDetailScreen> {
  late Stream<Part> _partStream;
  late Future<List<PartChild>> _partChildrenFuture;

  Future<void> _showCreatePartDialog() async {
    await showDialog(
      context: context,
      builder:(context) {
        return PartCreateDialog(
          onCreate: (name, description) async {
            await PartRepository.createPartForPart(widget.partId, name, description);
            setState(() {
              _partStream = PartRepository.getPartDetailStream(widget.partId);
              _partChildrenFuture = PartRepository.getPartChildren(widget.partId);
            });
          },
        );
      },
    );
  }

  Future<void> _showAssignItemDialog() async {
    await showDialog(
      context: context,
      builder:(context) {
        return PartItemCreateDialog(
          onCreate: (itemId, qty, description) async {
            await PartRepository.assignItemToPart(widget.partId, itemId, qty, description);
            setState(() {
              _partStream = PartRepository.getPartDetailStream(widget.partId);
              _partChildrenFuture = PartRepository.getPartChildren(widget.partId);
            });
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _partStream = PartRepository.getPartDetailStream(widget.partId);
    _partChildrenFuture = PartRepository.getPartChildren(widget.partId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
          )
        ]
      ),
      body: StreamBuilder<Part>(
        stream: _partStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final part = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(part.name),
                      part.description.isNotEmpty ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 250,
                          child: Card(
                            color: Colors.white, 
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: MarkdownBlock(data: part.description),
                              ),
                            ),
                          ),
                        ),
                      ) : SizedBox(height: 10),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: ElevatedButton(
                            onPressed: null,
                            child: Icon(Icons.edit))
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (widget.isVehiclePart) {
                                await PartRepository.unlinkPart(part.id, widget.parentId);
                              } else {
                                await PartRepository.deletePart(part.id);
                              }

                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Icon(Icons.delete)
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      FutureBuilder(
                        future: _partChildrenFuture,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator(),);
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                return PartChildren(
                                  title: widget.title,
                                  children: snapshot.data!,
                                  parentId: widget.partId,
                                  onPop: () {
                                    setState(() {
                                      _partChildrenFuture = PartRepository.getPartChildren(widget.partId);
                                    });
                                  },
                                );
                              } else {
                                return Text('Data not set');
                              }
                          }
                        },
                      )
                    ]
                  ),
                );
              } else {
                return Center(child: Text('Part not set'),);
              }
          }
        },
      ),
    );
  }
}

