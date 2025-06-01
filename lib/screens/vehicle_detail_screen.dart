import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:partie/components/part_create_dialog.dart';
import 'package:partie/components/vehicle_part_finder.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/part.dart';

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
  Future<void> _showCreatePartDialog() async {
    await showDialog(
      context: context,
      builder:(context) {
        return PartCreateDialog(
          onCreate: (name, description) async => {
            await PartRepository.createPartForVehicle(widget.vehicle.id, name, description)
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle.name),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: Icon(Icons.link),
            onPressed: () {
              
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: Icon(Icons.copy),
            onPressed: () {
              
            },
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: _showCreatePartDialog,
            child: Icon(Icons.add),
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(widget.vehicle.name),
            ),
            widget.vehicle.description.isEmpty ?
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
                        child: MarkdownBlock(data: widget.vehicle.description),
                      ),
                    ),
                  ),
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
            VehiclePartFinder(vehicleId: widget.vehicle.id,),
            SizedBox(
              height: 500,
            )
          ],
        ),
      ),
    );   
  }
}