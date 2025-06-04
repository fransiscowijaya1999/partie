import 'package:flutter/material.dart';
import 'package:partie/components/item_selection_dialog.dart';
import 'package:partie/components/part_item_form.dart';
import 'package:partie/database.dart';

class PartItemCreateDialog extends StatefulWidget {
  const PartItemCreateDialog({
    super.key,
    required this.onCreate
  });

  final Future Function(int itemId, String name, String description) onCreate;

  @override
  State<PartItemCreateDialog> createState() => _PartItemCreateDialogState();
}

class _PartItemCreateDialogState extends State<PartItemCreateDialog> {
  String qty = '';
  String description = '';
  Item? _selectedItem;
  
  bool isLoading = false;

  Future<void> _showItemSelectionDialog() async {
    await showDialog(
      context: context,
      builder:(context) {
        return ItemSelectionDialog(
          onSelected: (item) => setState(() {
            _selectedItem = item;
          }),
        );
      },
    );
  }

  void _setQty(String text) {
    setState(() {
      qty = text;
    });
  }

  void _setDesc(String text) {
    setState(() {
      description = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Assign Item'),
      contentPadding: EdgeInsets.all(10),
      children: [
        ElevatedButton(onPressed: _showItemSelectionDialog, child: _selectedItem != null ? Text(_selectedItem!.name) : Text('Select item')),
        SizedBox(height: 10,),
        PartItemForm(
          setQty: _setQty,
          setDescription: _setDesc,
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            TextButton(
              onPressed: isLoading || _selectedItem == null ? null : () async {
                await widget.onCreate(_selectedItem!.id, qty, description);
                if (context.mounted) {
                  Navigator.pop(context, null);
                }
              },
              child: isLoading ? Center(child: CircularProgressIndicator(),) : Text('Assign')
            ),
            TextButton(
              onPressed: () { Navigator.pop(context, null); },
              child: Icon(Icons.cancel)
            )
          ],
        )
      ],
    );
  }
}