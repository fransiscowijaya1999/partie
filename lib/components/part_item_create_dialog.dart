import 'package:flutter/material.dart';
import 'package:partie/components/item_selection_dialog.dart';
import 'package:partie/components/part_item_form.dart';
import 'package:partie/components/select_coordinate_dialog.dart';
import 'package:partie/database.dart';

class PartItemCreateDialog extends StatefulWidget {
  const PartItemCreateDialog({
    super.key,
    required this.onCreate,
    this.qty = '',
    this.description = '',
    this.item,
    this.title = 'Assign Item',
    this.buttonText = 'Assign',
    required this.imagePath,
    this.initialTopCoordinate,
    this.initialLeftCoordinate,
  });

  final String qty;
  final String description;
  final Item? item;
  final String title;
  final String buttonText;
  final String imagePath;
  final double? initialTopCoordinate;
  final double? initialLeftCoordinate;

  final Future Function(
    int itemId,
    String name,
    String description,
    double? topCoordinate,
    double? leftCoordinate,
  )
  onCreate;

  @override
  State<PartItemCreateDialog> createState() => _PartItemCreateDialogState();
}

class _PartItemCreateDialogState extends State<PartItemCreateDialog> {
  late String qty;
  late String description;
  Item? _selectedItem;
  Offset? _selectedCoordinate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    qty = widget.qty;
    description = widget.description;
    _selectedItem = widget.item;
    if (widget.initialTopCoordinate != null &&
        widget.initialLeftCoordinate != null) {
      _selectedCoordinate = Offset(
        widget.initialLeftCoordinate!,
        widget.initialTopCoordinate!,
      );
    }
  }

  Future<void> _showSelectCoordinateDialog() async {
    final Offset? coordinate = await showDialog<Offset>(
      context: context,
      builder: (context) {
        return SelectCoordinateDialog(imagePath: widget.imagePath);
      },
    );
    if (coordinate != null) {
      setState(() {
        _selectedCoordinate = coordinate;
      });
    }
  }

  Future<void> _showItemSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return ItemSelectionDialog(
          onSelected:
              (item) => setState(() {
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
      title: Text(widget.title),
      contentPadding: EdgeInsets.all(10),
      children: [
        ElevatedButton(
          onPressed: _showItemSelectionDialog,
          child:
              _selectedItem != null
                  ? Text(_selectedItem!.name)
                  : Text('Select item'),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed:
                    widget.imagePath.isNotEmpty
                        ? _showSelectCoordinateDialog
                        : null,
                child: Text(
                  _selectedCoordinate != null
                      ? 'Coordinate set'
                      : 'Select Coordinate',
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed:
                  _selectedCoordinate != null
                      ? () => setState(() => _selectedCoordinate = null)
                      : null,
              icon: Icon(Icons.refresh),
              tooltip: 'Reset coordinate',
            ),
          ],
        ),
        SizedBox(height: 10),
        PartItemForm(
          setQty: _setQty,
          setDescription: _setDesc,
          qty: qty,
          description: description,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            TextButton(
              onPressed:
                  isLoading || _selectedItem == null
                      ? null
                      : () async {
                        await widget.onCreate(
                          _selectedItem!.id,
                          qty,
                          description,
                          _selectedCoordinate?.dy,
                          _selectedCoordinate?.dx,
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
      ],
    );
  }
}
