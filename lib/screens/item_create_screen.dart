import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/vehicle_form_reactive.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';
import 'package:partie/utils/image_compressor.dart';

class ItemCreateScreen extends StatefulWidget {
  const ItemCreateScreen({ super.key });

  @override
  State<ItemCreateScreen> createState() => _ItemCreateScreenState();
}

class _ItemCreateScreenState extends State<ItemCreateScreen> {
  late Future<List<Item>> _duplicates;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  Uint8List? _image;

  void resetForm() {
    setState(() {
      nameController.text = '';
      descriptionController.text = '';
      _image = null;
      _duplicates = ItemRepository.filter(name: nameController.text, limit: 5);
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

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final compressed = await ImageCompressor.compressFile(picked.path);
    if (compressed == null) return;

    setState(() {
      _image = compressed;
    });
  }

  Future<void> _submitItem() async {
    await ItemRepository.createItem(
      nameController.text,
      descriptionController.text,
      image: _image != null ? Value(_image) : const Value.absent(),
    );

    resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Item'),),
      body: SingleChildScrollView(
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
            SizedBox(height: 10),
            _image != null
                ? Image.memory(_image!, height: 200)
                : const Text('No image'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
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
