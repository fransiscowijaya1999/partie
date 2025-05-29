import 'package:flutter/material.dart';

class DuplicateList extends StatelessWidget {
  const DuplicateList({
    super.key,
    required this.duplicates
  });

  final List<String> duplicates;

  @override
  Widget build(BuildContext context) {
    if (duplicates.isEmpty) {
      return Center(child: Text('No possible duplicate'),);
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: duplicates.length,
        itemBuilder:(context, index) => ListTile(
          title: Text(duplicates[index]),
        ),
      );
    }
  }
}