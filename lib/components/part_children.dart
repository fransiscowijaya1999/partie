import 'package:flutter/material.dart';
import 'package:partie/components/part_item_detail.dart';
import 'package:partie/models/part_child.dart';
import 'package:partie/screens/part_detail_screen.dart';

class PartChildren extends StatelessWidget {
  const PartChildren({
    super.key,
    required this.children,
    required this.parentId,
    this.onPop,
    this.onItemDelete,
    this.onItemUpdated,
    this.titleSegments = const [],
    required this.imagePath,
  });

  final List<PartChild> children;
  final int parentId;
  final List<String> titleSegments;
  final String imagePath;
  final VoidCallback? onPop;
  final ValueSetter<int?>? onItemDelete;
  final Function(
    int partItemId,
    int newItemId,
    String qty,
    String description,
    double? topCoordinate,
    double? leftCoordinate,
  )? onItemUpdated;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Center(child: Text('No child found'));
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: children.length,
      itemBuilder: (context, index) {
        final child = children[index];
        return Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: index < children.length ? 10 : 0,
          ),
          child:
              child.isCategory
                  ? PartItemDetail(
                    name: child.name,
                    imagePath: imagePath,
                    onTap:
                        child.isCategory
                            ? () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => PartDetailScreen(
                                        titleSegments: [
                                          ...titleSegments,
                                          child.name,
                                        ],
                                        partId: child.partId,
                                        parentId: parentId,
                                        isVehiclePart: false,
                                      ),
                                ),
                              );

                              onPop != null ? onPop!() : null;
                            }
                            : null,
                  )
                  : Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(10, 0, 0, 0),
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: PartItemDetail(
                      itemId: child.itemId,
                      name: child.name,
                      description: child.description,
                      qty: child.qty,
                      topCoordinate: child.topCoordinate,
                      leftCoordinate: child.leftCoordinate,
                      imagePath: imagePath,
                      onItemDelete: () {
                        if (onItemDelete != null) {
                          onItemDelete!(child.partItemId);
                        }
                      },
                      onItemUpdated: (
                        newItemId,
                        qty,
                        description,
                        topCoordinate,
                        leftCoordinate,
                      ) {
                        if (onItemUpdated != null) {
                          onItemUpdated!(
                            child.partItemId!,
                            newItemId,
                            qty,
                            description,
                            topCoordinate,
                            leftCoordinate,
                          );
                        }
                      },
                    ),
                  ),
        );
      },
    );
  }
}
