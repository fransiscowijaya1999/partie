import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_part_list.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';

class VehiclePartFinder extends StatefulWidget {
  const VehiclePartFinder({
    super.key,
    required this.parts,
    this.title = ''
  });

  final List<Part> parts;
  final String title;

  @override
  State<StatefulWidget> createState() => _VehiclePartFinderState();
}

class _VehiclePartFinderState extends State<VehiclePartFinder> {
  final queryController = TextEditingController();
  List<Part> parts = [];

  @override
  void initState() {
    super.initState();
    parts = widget.parts.where((part) => part.name.toUpperCase().contains(queryController.text.toUpperCase())).toList();
    queryController.addListener(() {
      setState(() {
        parts = widget.parts.where((part) => part.name.toUpperCase().contains(queryController.text.toUpperCase())).toList();
      });
    });
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: queryController,
                decoration: InputDecoration(
                  label: Text('Search...')
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        VehiclePartList(
          parts: parts,
          title: widget.title,
        )
      ]
    );
  }
}