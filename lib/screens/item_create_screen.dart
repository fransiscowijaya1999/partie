import 'package:flutter/material.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/vehicle_form_reactive.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';

class ItemCreateScreen extends StatefulWidget {
  const ItemCreateScreen({ super.key });

  @override
  State<ItemCreateScreen> createState() => _ItemCreateScreenState();
}

class _ItemCreateScreenState extends State<ItemCreateScreen> {
  late Future<List<Item>> _duplicates;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  void resetForm() {
    setState(() {
      nameController.text = '';
      descriptionController.text = '';
      setState(() {
        _duplicates = ItemRepository.filter(name: nameController.text, limit: 5);
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _duplicates = ItemRepository.filter(name: nameController.text, limit: 5);
    nameController.addListener(() {
      setState(() {
        _duplicates = ItemRepository.filter(name: nameController.text, limit: 5);
      });
    });
  }

  Future<void> _submitItem() async {
    await ItemRepository.createItem(nameController.text, descriptionController.text);

    resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Item'),),
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
            VehicleFormReactive(
              nameController: nameController,
              descriptionController: descriptionController,
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _submitItem,
              child: Text('Submit')
            )
          ],
        ),
      ),
    );
  }
}