import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:partie/components/vehicle_form.dart';

class PartCreateDialog extends StatefulWidget {
  const PartCreateDialog({
    super.key,
    required this.onCreate,
    this.name = '',
    this.description = '',
    this.catalogImage,
    this.title = 'Create Part',
    this.buttonText = 'Create',
  });

  final String name;
  final String description;
  final String? catalogImage;
  final String title;
  final String buttonText;
  final Future Function(
    String name,
    String description,
    String? catalogImagePath,
  )
  onCreate;

  @override
  State<PartCreateDialog> createState() => _PartCreateDialogState();
}

class _PartCreateDialogState extends State<PartCreateDialog> {
  late String name;
  late String description;
  late String? catalogImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    name = widget.name;
    description = widget.description;
    catalogImage = widget.catalogImage;
  }

  void _setCatalogImage(String path) {
    setState(() {
      catalogImage = path;
    });
  }

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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    _setCatalogImage(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              catalogImage != null
                  ? Image.file(File(catalogImage!), height: 250, width: 250)
                  : const Text('No catalog image'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              SizedBox(height: 10),
              VehicleForm(
                setName: _setName,
                setDescription: _setDesc,
                name: name,
                description: description,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              TextButton(
                onPressed:
                    isLoading
                        ? null
                        : () async {
                          await widget.onCreate(
                            name,
                            description,
                            catalogImage,
                          );
                          if (context.mounted) {
                            Navigator.pop(context, null);
                          }
                        },
                child:
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Text(widget.buttonText),
              ),
              Spacer(flex: 1),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child: Icon(Icons.cancel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
