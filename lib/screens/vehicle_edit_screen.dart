import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/vehicle_form.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/vehicle.dart';

class VehicleEditScreen extends StatefulWidget {
  const VehicleEditScreen({
    super.key,
    required this.id,
    this.name = '',
    this.description = '',
    this.parentVehicle
  });

  final int id;
  final String name;
  final String description;
  final Vehicle? parentVehicle;

  @override
  State<VehicleEditScreen> createState() => _VehicleEditScreenState();
}

class _VehicleEditScreenState extends State<VehicleEditScreen> {
  late Future<List<Vehicle>> _duplicates;

  String name = '';
  String description = '';
  Vehicle? selectedParent;
  final parentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    selectedParent = widget.parentVehicle;
    _duplicates = VehicleRepository.filter(name: name, limit: 5, ignoredId: widget.id);
  }

  Future<void> _updateVehicle() async {
    final parentId = selectedParent?.id;
    await VehicleRepository.updateVehicle(widget.id, name, description, parentId: parentId);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void setName(String text) {
    setState(() {
      name = text;
      _duplicates = VehicleRepository.filter(name: name, limit: 5, ignoredId: widget.id);
    });
  }

  void setDescription(String desc) {
    setState(() {
      description = desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Vehicle'),),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: name.length < 3 ?
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
                  items: (f, s) => VehicleRepository.filter(name: f, ignoredId: widget.id),
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
                  suffixProps: DropdownSuffixProps(
                    clearButtonProps: ClearButtonProps(
                      icon: Icon(Icons.restart_alt),
                      isVisible: true
                    )
                  ),
                )
              ),
            ),
            SizedBox(height: 10,),
            VehicleForm(
              setName: setName,
              setDescription: setDescription,
              name: name,
              description: description,
            ),
            SizedBox(height: 10,),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _updateVehicle,
              child: Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}