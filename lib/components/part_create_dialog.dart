import 'package:flutter/material.dart';
import 'package:partie/components/vehicle_form.dart';

class PartCreateDialog extends StatefulWidget {
  const PartCreateDialog({
    super.key,
    required this.onCreate,
    this.name = '',
    this.description = '',
    this.title = 'Create Part',
    this.buttonText = 'Create',
  });

  final String name;
  final String description;
  final String title;
  final String buttonText;
  final Future Function(String name, String description) onCreate;

  @override
  State<PartCreateDialog> createState() => _PartCreateDialogState();
}

class _PartCreateDialogState extends State<PartCreateDialog> {
  late String name;
  late String description;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    name = widget.name;
    description = widget.description;
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

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: VehicleForm(
            setName: _setName,
            setDescription: _setDesc,
            name: name,
            description: description,
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
                          await widget.onCreate(name, description);
                          if (context.mounted) {
                            Navigator.pop(context, null);
                          }
                        },
                child:
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Text(widget.buttonText),
              ),
              Spacer(flex: 1,),
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
