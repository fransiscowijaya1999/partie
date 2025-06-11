import 'package:flutter/material.dart';
import 'package:partie/components/main_scaffold.dart';
import 'package:partie/components/pagination.dart';
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
  int page = 0;
  final limit = 10;
  late VehicleListStream _vehiclesStream;
  final queryController = TextEditingController();

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _vehiclesStream = VehicleRepository.filterWithAggregateWatch(name: queryController.text, page: page, limit: limit);
    queryController.addListener(() {
      setState(() {
        page = 0;
        _vehiclesStream = VehicleRepository.filterWithAggregateWatch(name: queryController.text, page: page, limit: limit);
      });
    });
  }

  void movePage(int move) {
    setState(() {
      page += move;
      _vehiclesStream = VehicleRepository.filterWithAggregateWatch(name: queryController.text, page: page, limit: limit);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Vehicle',
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Padding(padding: EdgeInsets.all(10), child: TextField(
                  controller: queryController,
                  decoration: InputDecoration(
                    label: Text('Search...')
                  ),
                ),),
              ),
            ),
            StreamBuilder<List<Vehicle>>(
              stream: _vehiclesStream.vehicles,
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
            StreamBuilder<int>(
              stream: _vehiclesStream.count,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator(),);
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      final count = snapshot.data!;
                      
                      return Padding(padding: EdgeInsets.all(10), child: Pagination(
                        page: page,
                        count: count,
                        limit: limit,
                        onMove: (step) {
                          setState(() {
                            page += step;
                            _vehiclesStream = VehicleRepository.filterWithAggregateWatch(name: queryController.text, page: page, limit: limit);
                          });
                        }));
                    } else {
                      return Text('Not working');
                    }
                }
              }
            ),
            SizedBox(height: 100,)
          ],
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