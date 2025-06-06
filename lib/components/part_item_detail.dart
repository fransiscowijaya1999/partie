import 'package:flutter/material.dart';

class PartItemDetail extends StatelessWidget {
  const PartItemDetail({
    super.key,
    required this.name,
    this.qty = '',
    this.description = '',
    this.onTap
  });

  final String name;
  final String qty;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          SizedBox(height: 5,),
          if (qty.isNotEmpty) Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.black38
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.lightBlueAccent
            ),
            padding: EdgeInsets.all(5),
            child: Text(qty,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ),
          if (description.isNotEmpty) Text(description,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15
            )
          )
        ],
      ),
      onTap: onTap,
    );
  }
}