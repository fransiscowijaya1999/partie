import 'package:flutter/material.dart';

class PartItemForm extends StatefulWidget {
  const PartItemForm({
    super.key,
    this.setQty,
    this.setDescription,
    this.qty = '',
    this.description = ''
  });

  final ValueSetter<String>? setQty;
  final ValueSetter<String>? setDescription;
  final String qty;
  final String description;

  @override
  State<PartItemForm> createState() => _PartItemFormState();
}

class _PartItemFormState extends State<PartItemForm> {
  final qtyController = TextEditingController();
  final descriptionController = TextEditingController();

  void _setQty() {
    if (widget.setQty != null) { widget.setQty!(qtyController.text); }
  }

  void _setDesc() {
    if (widget.setDescription != null) {
      widget.setDescription!(descriptionController.text);
    }
  }

  @override
  void initState() {
    super.initState();

    qtyController.text = widget.qty;
    descriptionController.text = widget.description;
    qtyController.addListener(_setQty);
    descriptionController.addListener(_setDesc);
  }

  @override
  void dispose() {
    qtyController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: qtyController,
              decoration: decorationGenerator('Qty'),
            ),
            SizedBox(height: 5,),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 8,
              controller: descriptionController,
              decoration: decorationGenerator('Description'),
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration decorationGenerator(String labelText) {
  return InputDecoration(
    labelText: labelText
  );
}