import 'dart:io' show Directory, File;

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:markdown_widget/widget/markdown_block.dart';
import 'package:partie/components/catalog_view.dart';
import 'package:partie/components/part_children.dart';
import 'package:partie/components/part_create_dialog.dart';
import 'package:partie/components/part_item_create_dialog.dart';
import 'package:partie/database.dart';
import 'package:partie/models/part_child.dart';
import 'package:partie/repositories/part.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:uuid/uuid.dart' show Uuid;
import 'package:path/path.dart' as p;

class PartDetailScreen extends StatefulWidget {
  const PartDetailScreen({
    super.key,
    required this.titleSegments,
    required this.parentId,
    required this.partId,
    this.isVehiclePart = true,
  });

  final List<String> titleSegments;
  final int parentId;
  final int partId;
  final bool isVehiclePart;

  @override
  State<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends State<PartDetailScreen> {
  late List<String> titleSegments;
  late Stream<Part> _partStream;
  late Future<List<PartChild>> _partChildrenFuture;

  Future<void> _showCreatePartDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return PartCreateDialog(
          onCreate: (name, description, imagePath) async {
            await PartRepository.createPartForPart(
              widget.partId,
              name,
              Value(imagePath),
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
    String? initImagePath,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return PartCreateDialog(
          title: 'Edit: $initName',
          buttonText: 'Update',
          name: initName,
          description: initDescription,
          catalogImage: initImagePath,
          onCreate: (name, description, imagePath) async {
            String? finalPath;

            if (imagePath != null) {
              final Directory appDir = await getApplicationDocumentsDirectory();
              final String ext = p.extension(imagePath);

              if (initImagePath == null) {
                var uuid = Uuid();

                final String fileName = '${appDir.path}/${uuid.v4()}$ext';
                final String savedPath = p.join(appDir.path, fileName);

                await File(imagePath).copy(savedPath);

                finalPath = savedPath;
              } else {
                final String initFileName = p.basenameWithoutExtension(
                  imagePath,
                );
                final String fileName = '${appDir.path}/$initFileName$ext';
                final String savedPath = p.join(appDir.path, fileName);

                await File(imagePath).copy(savedPath);

                finalPath = savedPath;
              }
            }

            await PartRepository.updatePart(
              widget.partId,
              name,
              Value(finalPath),
              description,
            );

            setState(() {
              titleSegments = [
                ...titleSegments.sublist(0, titleSegments.length - 1),
                name,
              ];
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
    // Fetch the current part data
    final part = await _partStream.first;

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) {
        return PartItemCreateDialog(
          imagePath: part.catalogImagePath ?? '',
          onCreate: (
            itemId,
            qty,
            description,
            topCoordinate,
            leftCoordinate,
          ) async {
            await PartRepository.assignItemToPart(
              widget.partId,
              itemId,
              qty,
              description,
              topCoordinate,
              leftCoordinate,
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

    titleSegments = widget.titleSegments;
    _partStream = PartRepository.getPartDetailStream(widget.partId);
    _partChildrenFuture = PartRepository.getPartChildren(widget.partId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleSegments.join(' \\ '),
          style: TextStyle(fontSize: 12),
        ),
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

                return FutureBuilder<List<PartChild>>(
                  future: _partChildrenFuture,
                  builder: (context, childSnapshot) {
                    switch (childSnapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final children = childSnapshot.data ?? [];
                        final catalogItems =
                            children
                                .where((child) => !child.isCategory)
                                .where(
                                  (child) =>
                                      child.topCoordinate != null &&
                                      child.leftCoordinate != null,
                                )
                                .toList();

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                part.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              if (part.catalogImagePath != null)
                                CatalogView(
                                  imagePath: part.catalogImagePath!,
                                  items: catalogItems,
                                ),
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
                                                  padding: const EdgeInsets.all(
                                                    15,
                                                  ),
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
                                              part.catalogImagePath,
                                            ),
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (widget.isVehiclePart) {
                                          await PartRepository.unlinkPart(
                                            part.id,
                                            widget.parentId,
                                          );
                                        } else {
                                          await PartRepository.deletePart(
                                            part.id,
                                          );
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
                              PartChildren(
                                titleSegments: titleSegments,
                                children: children,
                                parentId: widget.partId,
                                imagePath: part.catalogImagePath ?? '',
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
                                  partItemId,
                                  newItemId,
                                  qty,
                                  description,
                                  topCoordinate,
                                  leftCoordinate,
                                ) async {
                                  await PartRepository.updatePartItem(
                                    partItemId,
                                    newItemId,
                                    qty,
                                    description,
                                    topCoordinate,
                                    leftCoordinate,
                                  );

                                  setState(() {
                                    _partChildrenFuture =
                                        PartRepository.getPartChildren(
                                          widget.partId,
                                        );
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                    }
                  },
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
