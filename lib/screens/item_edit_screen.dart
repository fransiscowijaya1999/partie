import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/vehicle_form.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';
import 'package:partie/utils/image_compressor.dart';

class ItemEditScreen extends StatefulWidget {
  const ItemEditScreen({
    super.key,
    required this.id,
    this.name = '',
    this.description = '',
    this.image,
  });

  final int id;
  final String name;
  final String description;
  final Uint8List? image;

  @override
  State<ItemEditScreen> createState() => _ItemEditScreenState();
}

class _ItemEditScreenState extends State<ItemEditScreen> {
  late Future<List<Item>> _duplicates;

  String name = '';
  String description = '';
  Uint8List? _image;
  bool _imageChanged = false;

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    _image = widget.image;
    _duplicates = ItemRepository.filter(
      name: name,
      limit: 5,
      ignoredId: widget.id,
    );
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final compressed = await ImageCompressor.compressFile(picked.path);
    if (compressed == null) return;

    setState(() {
      _image = compressed;
      _imageChanged = true;
    });
  }

  void _removeImage() {
    setState(() {
      _image = null;
      _imageChanged = true;
    });
  }

  Future<void> _updateItem() async {
    await ItemRepository.updateItem(
      widget.id,
      name,
      description,
      image: _imageChanged ? Value(_image) : const Value.absent(),
    );
    if (mounted) {
      Navigator.of(context).pop(
        Item(
          id: widget.id,
          name: name,
          description: description,
          image: _image,
        ),
      );
    }
  }

  void setName(String text) {
    setState(() {
      name = text;
      _duplicates = ItemRepository.filter(
        name: name,
        limit: 5,
        ignoredId: widget.id,
      );
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
      appBar: AppBar(
        title: Text('Edit: ${widget.name}', style: TextStyle(fontSize: 12)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child:
                  name.length < 3
                      ? Center(child: Text('Type atleast 3 characters name'))
                      : FutureBuilder(
                        future: _duplicates,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.active:
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.done:
                              if (snapshot.hasData) {
                                final duplicates =
                                    snapshot.data!.map((v) => v.name).toList();

                                return DuplicateList(duplicates: duplicates);
                              } else {
                                return DuplicateList(duplicates: []);
                              }
                          }
                        },
                      ),
            ),
            SizedBox(height: 10),
            _image != null
                ? Image.memory(_image!, height: 200)
                : const Text('No image'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Select Image'),
                ),
                if (_image != null) ...[
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _removeImage,
                    child: const Icon(Icons.delete),
                  ),
                ],
              ],
            ),
            SizedBox(height: 10),
            VehicleForm(
              setName: setName,
              setDescription: setDescription,
              name: name,
              description: description,
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _updateItem, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
