import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  const Pagination({
    super.key,
    required this.page,
    required this.count,
    required this.limit,
    required this.onMove
  });

  final int page;
  final int count;
  final int limit;
  final ValueSetter<int> onMove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(child: ElevatedButton(
              onPressed: page < 1 ? null : () => onMove(-1),
              child: Icon(Icons.arrow_left))
            ),
            SizedBox(width: 10,),
            Expanded(child: ElevatedButton(
              onPressed: page >= (count / limit).floor() ? null : () => onMove(1),
              child: Icon(Icons.arrow_right))
            )
          ],
        )
      )
    );
  }
}