import 'package:flutter/material.dart';
import 'package:partie/components/delete_confirmation_dialog.dart';
import 'package:partie/components/part_item_create_dialog.dart';
import 'package:partie/database.dart';

class PartItemDetail extends StatelessWidget {
  const PartItemDetail({
    super.key,
    this.itemId,
    required this.name,
    this.qty = '',
    this.description = '',
    this.onTap,
    this.onItemDelete,
    this.onItemUpdated
  });

  final int? itemId;
  final String name;
  final String qty;
  final String description;
  final VoidCallback? onTap;
  final VoidCallback? onItemDelete;
  final Function(int itemId, String name, String description)? onItemUpdated;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
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
          ),
          if (onItemDelete != null || onItemUpdated != null) Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PopupMenuButton(
                itemBuilder:(context) {
                  return <PopupMenuEntry>[
                    if (onItemUpdated != null) PopupMenuItem(
                      onTap: itemId != null ? () async {
                        await showDialog(context: context, builder: (context) {
                          return PartItemCreateDialog(
                            onCreate: (id, name, description) async {
                              onItemUpdated!(id, name, description);
                            },
                            qty: qty,
                            description: description,
                            item: itemId != null ? Item(id: itemId!, name: name, description: description) : null,
                          );
                        });
                      } : null,
                      child: Icon(Icons.edit),
                    ),
                    if (onItemDelete != null) PopupMenuItem(
                      child: Icon(Icons.delete),
                      onTap: () async {
                        final confirm = await showDialog(context: context, builder: (context) {
                          return DeleteConfirmationDialog();
                        });

                        if (confirm != null && confirm && onItemDelete != null) {
                          onItemDelete!();
                        }
                      },
                    )
                  ];
                },
              ),
            ],
          ),
        ],
      ),
      onTap: onTap
    );
  }
}