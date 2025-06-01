import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_form.dart';

class PartCreateScreen extends StatefulWidget {
  const PartCreateScreen({
    super.key
  });

  @override
  State<PartCreateScreen> createState() => _PartCreateScreenState();
}

class _PartCreateScreenState extends State<PartCreateScreen> {
  String name = '';
  String description = '';

  void _setName(String text) {
    setState(() {
      name = text;
    });
  }

  void _setDesc(String text) {
    setState(() {
      description = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Part'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              VehicleForm(
                setName: _setName,
                setDescription: _setDesc,
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}