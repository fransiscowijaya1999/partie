import 'package:flutter/material.dart';
import 'package:partie/models/part_child.dart';
import 'package:partie/screens/part_detail_screen.dart';
import 'package:partie/utils/string_builder.dart';

class PartChildren extends StatelessWidget {
  const PartChildren({
    super.key,
    required this.children,
    required this.parentId,
    this.onPop,
    this.title = ''
  });

  final List<PartChild> children;
  final int parentId;
  final String title;
  final VoidCallback? onPop;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Center(
        child: Text('No child found')
      );
    }
    
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: children.length,
      itemBuilder:(context, index) {
        final child = children[index];

        return ListTile(
          title: Text(child.name),
          onTap: child.isCategory ? () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PartDetailScreen(
                title: StringBuilder.titleBuilder(title, child.name),
                partId: child.id,
                parentId: parentId,
                isVehiclePart: false,
              )),
            );

            onPop != null ? onPop!() : null;
          } : null,
        );
      },
    );
  }
}