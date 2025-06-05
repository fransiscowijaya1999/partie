import 'package:flutter/material.dart';
import 'package:partie/database.dart';
import 'package:partie/screens/vehicle_detail_screen.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({
    super.key,
    this.vehicles
  });

  final List<Vehicle>? vehicles;

  @override
  Widget build(BuildContext context) {
    if (vehicles == null) {
      return Center(child: Text('Vehicle not set'),);
    } else if (vehicles!.isEmpty) {
      return Center(child: Text('Vehicle not found'),);
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: vehicles!.length,
        itemBuilder: (context, index) {
          final vehicle = vehicles![index];

          return ListTile(
            title: Text(vehicle.name),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VehicleDetailScreen(
                  vehicle: vehicle,
                )),
              );
            },
          );
        },
      );    
    }
  }
}