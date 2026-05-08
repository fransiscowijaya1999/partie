import 'package:flutter/material.dart';

class CatalogDotDialog extends StatelessWidget {
  const CatalogDotDialog({
    super.key,
    required this.name,
    required this.qty,
    required this.description,
  });

  final String name;
  final String qty;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (qty.isNotEmpty)
            Text(qty, style: TextStyle(fontWeight: FontWeight.bold)),
          if (description.isNotEmpty) Text(description),
        ],
      ),
    );
  }
}
