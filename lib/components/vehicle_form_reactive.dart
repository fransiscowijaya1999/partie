import 'package:flutter/material.dart';

class VehicleFormReactive extends StatefulWidget {
  const VehicleFormReactive({
    super.key,
    required this.nameController,
    required this.descriptionController,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;

  @override
  State<VehicleFormReactive> createState() => _VehicleFormReactiveState();
}

class _VehicleFormReactiveState extends State<VehicleFormReactive> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: widget.nameController,
              decoration: decorationGenerator('Name'),
            ),
            SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 8,
              controller: widget.descriptionController,
              decoration: decorationGenerator('Description'),
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration decorationGenerator(String labelText) {
  return InputDecoration(
    labelText: labelText
  );
}