import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partie/database.dart';
import 'package:partie/screens/part_detail_screen.dart';

class VehiclePartList extends StatelessWidget {
  const VehiclePartList({
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
  Widget build(BuildContext context) {
    if (parts.isEmpty) {
      return Center(child: Text('No part found'));
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: parts.length,
      itemBuilder: (context, index) {
        final part = parts[index];

        return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (part.catalogImagePath != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Image.file(
                    File(part.catalogImagePath!),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              Text(part.name),
            ],
          ),
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder:
                    (context) => PartDetailScreen(
                      titleSegments: [...titleSegments, part.name],
                      parentId: vehicleId,
                      partId: part.id,
                    ),
              ),
            );

            if (onPop != null) {
              onPop!();
            }
          },
        );
      },
    );
  }
}
