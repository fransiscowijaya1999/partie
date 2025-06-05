import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:partie/components/part_create_dialog.dart';
import 'package:partie/components/part_selection_dialog.dart';
import 'package:partie/components/vehicle_part_finder.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/part.dart';
import 'package:partie/repositories/vehicle.dart';
import 'package:partie/screens/vehicle_edit_screen.dart';

class VehicleDetailScreen extends StatefulWidget {
  const VehicleDetailScreen({
    super.key,
    required this.vehicle
  });

  final Vehicle vehicle;

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  late Future<Vehicle> _vehicleFuture;
  late Future<List<Part>> _partsFuture;

  @override
  void initState() {
    super.initState();
    _vehicleFuture = VehicleRepository.getVehicleNotNull(widget.vehicle.id);
    _partsFuture = VehicleRepository.searchPart(widget.vehicle.id, parentId: widget.vehicle.parentId);
  }

  Future<void> _showCreatePartDialog(int? parentId) async {
    await showDialog(
      context: context,
      builder:(context) {
        return PartCreateDialog(
          onCreate: (name, description) async {
            await PartRepository.createPartForVehicle(widget.vehicle.id, name, description);

            setState(() {
              _partsFuture = VehicleRepository.searchPart(widget.vehicle.id, parentId: parentId);
            });
          },
        );
      },
    );
  }

  Future<void> _showLinkPartDialog(int? parentId) async {
    await showDialog(
      context: context,
      builder:(context) {
        return PartSelectionDialog(
          onSelected: (part) async {
            PartRepository.linkPartForVehicle(part.id, widget.vehicle.id);

            setState(() {
              _partsFuture = VehicleRepository.searchPart(widget.vehicle.id, parentId: parentId);
            });
          },
        );
      },
    );
  }

  Future<void> _showDuplicatePartDialog(int? parentId) async {
    await showDialog(
      context: context,
      builder:(context) {
        return PartSelectionDialog(
          onSelected: (part) async {
            PartRepository.duplicatePartForVehicle(part.id, widget.vehicle.id);

            setState(() {
              _partsFuture = VehicleRepository.searchPart(widget.vehicle.id, parentId: parentId);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _vehicleFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Scaffold(body: Center(child: CircularProgressIndicator(),));
          case ConnectionState.done:
            final vehicle = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: Text(vehicle.name),
              ),
              floatingActionButtonLocation: ExpandableFab.location,
              floatingActionButton: ExpandableFab(
                children: [
                  FloatingActionButton.small(
                    heroTag: null,
                    child: Icon(Icons.link),
                    onPressed: () => _showLinkPartDialog(vehicle.parentId),
                  ),
                  FloatingActionButton.small(
                    heroTag: null,
                    child: Icon(Icons.copy),
                    onPressed: () => _showDuplicatePartDialog(vehicle.parentId),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _showCreatePartDialog(vehicle.parentId),
                    child: Icon(Icons.add),
                  )
                ]
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(vehicle.name),
                    vehicle.parentId != null ?
                    FutureBuilder(
                      future: vehicle.parentId != null ? VehicleRepository.getVehicle(vehicle.parentId!) : null,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final parent = snapshot.data!;
                          return Text('Inherit: ${parent.name}');
                        } else {
                          return Text('Error fetching data');
                        }
                      },
                    )
                    : Text('Inherit nothing'),
                    vehicle.description.isEmpty ?
                    Center(child: Text('No description yet.'),) :
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 350,
                        child: Card(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: MarkdownBlock(data: vehicle.description),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: FutureBuilder(
                        future: vehicle.parentId != null ? VehicleRepository.getVehicle(vehicle.parentId!) : null,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final int? pId = await Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => VehicleEditScreen(
                                        id: vehicle.id,
                                        name: vehicle.name,
                                        description: vehicle.description,
                                        parentVehicle: snapshot.data,
                                      )),
                                    );

                                    setState(() {
                                      _vehicleFuture = VehicleRepository.getVehicleNotNull(widget.vehicle.id);
                                      _partsFuture = VehicleRepository.searchPart(widget.vehicle.id, parentId: pId);
                                    });
                                  },
                                  child: Icon(Icons.edit)
                                ),
                              ),
                              SizedBox(width: 10,),
                              ElevatedButton(onPressed: () async {
                                await VehicleRepository.deleteVehicle(vehicle.id);
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }, child: Icon(Icons.delete))
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15,),
                    Center(
                      child: Text('Parts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    FutureBuilder(future: _partsFuture, builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator(),);
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            final parts = snapshot.data!;

                            return VehiclePartFinder(
                              title: vehicle.name,
                              parts: parts,
                              vehicleId: vehicle.id,
                              onPop: () {
                                setState(() {
                                  _partsFuture = VehicleRepository.searchPart(widget.vehicle.id, parentId: vehicle.parentId);
                                });
                              },
                            );
                          } else {
                            return Text('Data not set');
                          }
                      }
                    }),
                    SizedBox(height: 300,)
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}