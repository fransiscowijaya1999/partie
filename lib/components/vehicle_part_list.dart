import 'package:flutter/material.dart';
import 'package:partie/database.dart';
import 'package:partie/screens/part_detail_screen.dart';
import 'package:partie/utils/string_builder.dart';

class VehiclePartList extends StatelessWidget {
  const VehiclePartList({
    super.key,
    required this.parts,
    this.title = ''
  });

  final List<Part> parts;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (parts.isEmpty) {
      return Center(
        child: Text('No part found')
      );
    }
    
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: parts.length,
      itemBuilder:(context, index) {
        final part = parts[index];

        return ListTile(
          title: Text(part.name),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PartDetailScreen(
                title: StringBuilder.titleBuilder(title, part.name),
                partId: part.id,
              )),
            );
          },
        );
      },
    );
  }
}