import 'package:flutter/material.dart';
import 'package:partie/components/duplicate_list.dart';
import 'package:partie/components/vehicle_form.dart';
import 'package:partie/database.dart';
import 'package:partie/repositories/item.dart';

class ItemEditScreen extends StatefulWidget {
  const ItemEditScreen({
    super.key,
    required this.id,
    this.name = '',
    this.description = '',
  });

  final int id;
  final String name;
  final String description;

  @override
  State<ItemEditScreen> createState() => _ItemEditScreenState();
}

class _ItemEditScreenState extends State<ItemEditScreen> {
  late Future<List<Item>> _duplicates;

  String name = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    name = widget.name;
    description = widget.description;
    _duplicates = ItemRepository.filter(
      name: name,
      limit: 5,
      ignoredId: widget.id,
    );
  }

  Future<void> _updateItem() async {
    await ItemRepository.updateItem(widget.id, name, description);
    if (mounted) {
      Navigator.of(
        context,
      ).pop(Item(id: widget.id, name: name, description: description));
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
      body: Padding(
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
