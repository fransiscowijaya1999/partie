import 'package:flutter/material.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/item_list.dart';
import 'package:partie/components/main_scaffold.dart';
import 'package:partie/components/vehicle_list.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';
import 'package:partie/screens/vehicle_create_screen.dart';

class VehiclesScreen extends StatefulWidget {
  const VehiclesScreen({
    super.key,
  });

  @override
  State<VehiclesScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehiclesScreen> {
  late Stream<List<Vehicle>> _vehiclesStream;

  @override
  void initState() {
    super.initState();

    _vehiclesStream = VehicleRepository.filterWatch();
  }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Vehicle',
      body: StreamBuilder<List<Vehicle>>(
        stream: _vehiclesStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                final vehicles = snapshot.data!;

                return VehicleList(vehicles: vehicles);
              } else {
                return VehicleList(vehicles: []);
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const VehicleCreateScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}