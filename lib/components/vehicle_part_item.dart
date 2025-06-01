import 'package:flutter/material.dart';

class VehiclePartItem extends StatelessWidget {
  const VehiclePartItem({
    super.key,
    required this.name,
    this.description
  });

  final String name;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(name),
      children: [
        Text(description ?? '')
      ],
    );
  }
}
