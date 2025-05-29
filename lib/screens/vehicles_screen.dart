import 'package:flutter/material.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/main_scaffold.dart';
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
  late Future<List<Vehicle>> _duplicates;

  @override
  void initState() {
    super.initState();

    _duplicates = VehicleRepository.filter();
  }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Vehicle',
      body: Center(
        child: FutureBuilder(
          future: _duplicates,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final duplicates = snapshot.data!.map((v) => v.name).toList();

                  return DuplicateList(duplicates: duplicates);
                } else {
                  return DuplicateList(duplicates: []);
                }
              default:
                return Text('error');
            }
          },
        ),
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