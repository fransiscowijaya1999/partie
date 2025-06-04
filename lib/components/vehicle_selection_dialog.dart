import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_list.dart';
import 'package:partie/components/vehicle_selection_list.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';

class VehicleSelectionDialog extends StatefulWidget {
  const VehicleSelectionDialog({
    super.key,
    required this.onSelected
  });

  final ValueSetter<Vehicle> onSelected;

  @override
  State<VehicleSelectionDialog> createState() => _VehicleSelectionDialogState();
}

class _VehicleSelectionDialogState extends State<VehicleSelectionDialog> {
  final queryController = TextEditingController();
  late Future<List<Vehicle>> _vehicleFuture;

  @override
  void initState() {
    super.initState();
    _vehicleFuture = VehicleRepository.filter(name: queryController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select Vehicle'),
      children: [
        FutureBuilder<List<Vehicle>>(
          future: _vehicleFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final vehicles = snapshot.data!;

                return SizedBox(
                  height: 300,
                  width: 300,
                  child: VehicleSelectionList(
                    onSelected: widget.onSelected,
                    vehicles: vehicles,
                  ),
                );
              } else {
                return VehicleList(vehicles: []);
              }
            }
          }
        )
      ],
    );
  }
}