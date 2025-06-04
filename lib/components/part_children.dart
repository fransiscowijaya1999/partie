import 'package:flutter/material.dart';
import 'package:partie/models/part_child.dart';
import 'package:partie/screens/part_detail_screen.dart';

class PartChildren extends StatelessWidget {
  const PartChildren({
    super.key,
    required this.children,
    this.title = ''
  });

  final List<PartChild> children;
  final String title;

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
          onTap: child.isCategory ? () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PartDetailScreen(
                title: title.isEmpty ? '$title \\ ${child.name}' : child.name,
                partId: child.id,
              )),
            );
          } : null,
        );
      },
    );
  }
}