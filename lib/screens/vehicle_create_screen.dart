import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/vehicle_form_reactive.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';

class VehicleCreateScreen extends StatefulWidget {
  const VehicleCreateScreen({ super.key });

  @override
  State<VehicleCreateScreen> createState() => _VehicleCreateScreenState();
}

class _VehicleCreateScreenState extends State<VehicleCreateScreen> {
  late Future<List<Vehicle>> _duplicates;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  Vehicle? selectedParent;
  final parentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _duplicates = VehicleRepository.filter(name: nameController.text, limit: 5);
    nameController.addListener(() {
      setState(() {
        _duplicates = VehicleRepository.filter(name: nameController.text, limit: 5);
      });
    });
  }

  void _resetForm() {
    setState(() {
      selectedParent = null;
      nameController.text = '';
      descriptionController.text = '';
    });
  }

  Future<void> _submitVehicle() async {
    final parentId = selectedParent?.id;
    await VehicleRepository.createVehicle(nameController.text, descriptionController.text, parentId: parentId);

    _resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Vehicle'),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: nameController.text.length < 3 ?
                Center(child: Text('Type atleast 3 characters name'),)
                : FutureBuilder(
                  future: _duplicates,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          final duplicates = snapshot.data!.map((v) => v.name).toList();

                          return DuplicateList(duplicates: duplicates);
                        } else {
                          return DuplicateList(duplicates: []);
                        }
                    }
                  },
                )
            ),
            SizedBox(height: 10,),
            Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: DropdownSearch<Vehicle>(
                  items: (f, s) => VehicleRepository.filter(name: f),
                  itemAsString: (item) => item.name,
                  selectedItem: selectedParent,
                  compareFn: (i, s) => i.id == s.id,
                  onChanged: (value) => setState(() {
                    selectedParent = value;
                  }),
                  popupProps: PopupProps.bottomSheet(
                    searchDelay: Duration(milliseconds: 300),
                    disableFilter: true,
                    showSearchBox: true,
                    itemBuilder: (context, item, isDisabled, isSelected) =>
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(item.name),
                    ),
                  ),
                )
              ),
            ),
            SizedBox(height: 10,),
            VehicleFormReactive(nameController: nameController, descriptionController: descriptionController),
            SizedBox(height: 10,),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _submitVehicle,
              child: Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}