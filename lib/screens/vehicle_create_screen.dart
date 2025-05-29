import 'package:flutter/material.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/vehicle_form.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';

class VehicleCreateScreen extends StatefulWidget {
  const VehicleCreateScreen({ super.key });

  @override
  State<VehicleCreateScreen> createState() => _VehicleCreateScreenState();
}

class _VehicleCreateScreenState extends State<VehicleCreateScreen> {
  late Future<List<Vehicle>> _duplicates;
  String name = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    _duplicates = VehicleRepository.filter();
  }

  Future<void> _submitVehicle() async {
    await VehicleRepository.createVehicle(name, description);
  }

  void setName(String text) {
    setState(() {
      name = text;
    });
  }

  void setDescription(String desc) {
    setState(() {
      description = desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Vehicle'),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 250,
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
              )
            ),
            SizedBox(height: 10,),
            VehicleForm(
              setName: setName,
              setDescription: setDescription,
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _submitVehicle,
              child: Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}