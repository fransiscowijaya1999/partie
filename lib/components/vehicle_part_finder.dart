import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_part_list.dart';
import 'package:partie/database.dart';
import 'package:partie/utils/search_query.dart';

class VehiclePartFinder extends StatefulWidget {
  const VehiclePartFinder({
    super.key,
    required this.parts,
    required this.vehicleId,
    this.onPop,
    this.titleSegments = const [],
  });

  final List<Part> parts;
  final int vehicleId;
  final List<String> titleSegments;
  final VoidCallback? onPop;

  @override
  State<StatefulWidget> createState() => _VehiclePartFinderState();
}

class _VehiclePartFinderState extends State<VehiclePartFinder> {
  final queryController = TextEditingController();
  List<Part> parts = [];

  List<Part> _filter() {
    final tokens = SearchQuery.tokenize(queryController.text);
    return widget.parts
        .where((part) => SearchQuery.matchesAll(part.name, tokens))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    parts = _filter();
    queryController.addListener(() {
      setState(() {
        parts = _filter();
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
                decoration: InputDecoration(label: Text('Search...')),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        VehiclePartList(
          parts: parts,
          vehicleId: widget.vehicleId,
          titleSegments: widget.titleSegments,
          onPop: widget.onPop,
        ),
      ],
    );
  }
}
