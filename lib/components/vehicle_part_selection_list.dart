import 'package:flutter/material.dart';
import 'package:partie/database.dart';

class VehiclePartSelectionList extends StatelessWidget {
  const VehiclePartSelectionList({
    super.key,
    this.parts,
    required this.onSelected
  });

  final List<Part>? parts;
  final ValueSetter<Part> onSelected;

  @override
  Widget build(BuildContext context) {
    if (parts == null) {
      return Center(child: Text('Part not set'),);
    } else if (parts!.isEmpty) {
      return Center(child: Text('Part not found'),);
    } else {
      return ListView.builder(
        itemCount: parts!.length,
        itemBuilder: (context, index) {
          final part = parts![index];

          return ListTile(
            title: Text(part.name),
            onTap: () => onSelected(part)
          );
        },
      );    
    }
  }
}