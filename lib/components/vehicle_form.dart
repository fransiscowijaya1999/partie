import 'package:flutter/material.dart';

class VehicleForm extends StatefulWidget {
  const VehicleForm({
    super.key,
    this.setName,
    this.setDescription,
    this.name = '',
    this.description = '',
  });

  final ValueSetter<String>? setName;
  final ValueSetter<String>? setDescription;
  final String name;
  final String description;

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  void _setName() {
    if (widget.setName != null) {
      widget.setName!(nameController.text);
    }
  }

  void _setDesc() {
    if (widget.setDescription != null) {
      widget.setDescription!(descriptionController.text);
    }
  }

  @override
  void initState() {
    super.initState();

    nameController.text = widget.name;
    descriptionController.text = widget.description;
    nameController.addListener(_setName);
    descriptionController.addListener(_setDesc);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              enableSuggestions: false,
              controller: nameController,
              decoration: decorationGenerator('Name'),
            ),
            SizedBox(height: 10),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(fontSize: 12),
                  enableSuggestions: false,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 10,
                  controller: descriptionController,
                  decoration: decorationGenerator('Description'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration decorationGenerator(String labelText) {
  return InputDecoration(labelText: labelText);
}
