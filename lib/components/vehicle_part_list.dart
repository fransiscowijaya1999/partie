import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_part_item.dart';
import 'package:partie/database.dart';

class VehiclePartList extends StatelessWidget {
  const VehiclePartList({
    super.key,
    required this.parts
  });

  final List<Part> parts;

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

        return VehiclePartItem(
          name: part.name,
          description: part.description,
        );
      },
    );
  }
}