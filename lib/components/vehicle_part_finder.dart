import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_part_list.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';

class VehiclePartFinder extends StatefulWidget {
  const VehiclePartFinder({
    super.key,
    required this.vehicleId,
    this.parentId,
    this.title = ''
  });

  final int vehicleId;
  final int? parentId;
  final String title;

  @override
  State<StatefulWidget> createState() => _VehiclePartFinderState();
}

class _VehiclePartFinderState extends State<VehiclePartFinder> {
  final queryController = TextEditingController();

  late Stream<List<Part>> _stream;

  @override
  void initState() {
    super.initState();

    _stream = VehicleRepository.searchPartWatch(widget.vehicleId, parentId: widget.parentId);
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
        StreamBuilder<List<Part>>(
          stream: _stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(),);
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final parts = snapshot.data!;

                  return  VehiclePartList(
                    parts: parts,
                    title: widget.title,
                  );
                } else {
                  return VehiclePartList(parts: []);
                }
            }
          },
      )
      ],
    );
  }
}