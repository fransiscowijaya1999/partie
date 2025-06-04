import 'package:flutter/material.dart';
import 'package:partie/database.dart';

class VehicleSelectionList extends StatelessWidget {
  const VehicleSelectionList({
    super.key,
    this.vehicles,
    required this.onSelected
  });

  final List<Vehicle>? vehicles;
  final ValueSetter<Vehicle> onSelected;

  @override
  Widget build(BuildContext context) {
    if (vehicles == null) {
      return Center(child: Text('Vehicle not set'),);
    } else if (vehicles!.isEmpty) {
      return Center(child: Text('Vehicle not found'),);
    } else {
      return ListView.builder(
        itemCount: vehicles!.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles![index];

          return ListTile(
            title: Text(vehicle.name),
            onTap: () => onSelected(vehicle)
          );
        },
      );    
    }
  }
}