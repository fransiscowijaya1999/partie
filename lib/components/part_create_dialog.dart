import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_form.dart';

class PartCreateDialog extends StatefulWidget {
  const PartCreateDialog({
    super.key,
    required this.onCreate
  });

  final Future Function(String name, String description) onCreate;

  @override
  State<PartCreateDialog> createState() => _PartCreateDialogState();
}

class _PartCreateDialogState extends State<PartCreateDialog> {
  String name = '';
  String description = '';
  bool isLoading = false;

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
    return SimpleDialog(
      title: Text('Create Part'),
      children: [
        VehicleForm(
          setName: _setName,
          setDescription: _setDesc,
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            TextButton(
              onPressed: isLoading ? null : () async {
                await widget.onCreate(name, description);
                if (context.mounted) {
                  Navigator.pop(context, null);
                }
              },
              child: isLoading ? Center(child: CircularProgressIndicator(),) : Text('Create')
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