import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_part_selection_list.dart';
import 'package:partie/components/vehicle_selection_list.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';

class PartSelectionDialog extends StatefulWidget {
  const PartSelectionDialog({
    super.key,
    required this.onSelected
  });

  final ValueSetter<Part> onSelected;

  @override
  State<PartSelectionDialog> createState() => _PartSelectionDialogState();
}

class _PartSelectionDialogState extends State<PartSelectionDialog> {
  final queryController = TextEditingController();
  late Future<List<Vehicle>> _vehicleFuture;
  late Future<List<Part>> _partFuture;

  Vehicle? _selectedVehicle;

  @override
  void initState() {
    super.initState();
    _vehicleFuture = VehicleRepository.filter(name: queryController.text);
    queryController.addListener(() {
      setState(() {
        _vehicleFuture = VehicleRepository.filter(name: queryController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select Part'),
      children: [
        _selectedVehicle != null ? Padding(padding: EdgeInsets.all(10), child: ElevatedButton(
          onPressed: () {
            setState(() {
              _selectedVehicle = null;
              queryController.addListener(() {
                setState(() {
                  _vehicleFuture = VehicleRepository.filter(name: queryController.text);
                });
              });
            });
          },
          child: Icon(Icons.arrow_back)
          )) : Text('Select Vehicle'),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: queryController,
            decoration: InputDecoration(
              label: Text('Search')
            ),
          ),
        ),
        _selectedVehicle != null ?
        SizedBox(
          height: 300,
          width: 300,
          child: FutureBuilder(future: _partFuture, builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final parts = snapshot.data!;
          
                  return VehiclePartSelectionList(
                    onSelected: (part) => widget.onSelected(part),
                    parts: parts,
                  );
                } else {
                  return Text('Error loading data');
                }
            }
          }),
        )
        : SizedBox(
          height: 300,
          width: 300,
          child: FutureBuilder<List<Vehicle>>(
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
          
                  return VehicleSelectionList(
                    onSelected: (vehicle) {
                      setState(() {
                        _selectedVehicle = vehicle;
                        _partFuture = VehicleRepository.searchPart(vehicle.id, name: queryController.text);
                        queryController.addListener(() {
                          setState(() {
                            _partFuture = VehicleRepository.searchPart(vehicle.id, name: queryController.text);
                          });
                        });
                      });
                    },
                    vehicles: vehicles,
                  );
                } else {
                  return Text('Error loading data');
                }
              }
            }
          ),
        )
      ],
    );
  }
}