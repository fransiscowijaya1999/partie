import 'dart:typed_data';

import 'package:flutter/material.dart';

class CatalogDotDialog extends StatelessWidget {
  const CatalogDotDialog({
    super.key,
    required this.name,
    required this.qty,
    required this.description,
    this.image,
  });

  final String name;
  final String qty;
  final String description;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Image.memory(image!, height: 200),
            ),
          if (qty.isNotEmpty)
            Text(qty, style: TextStyle(fontWeight: FontWeight.bold)),
          if (description.isNotEmpty) Text(description),
        ],
      ),
    );
  }
}
