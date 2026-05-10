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

  int get _lastPage => count <= 0 ? 0 : (count - 1) ~/ limit;

  @override
  Widget build(BuildContext context) {
    final lastPage = _lastPage;

    if (page > lastPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onMove(lastPage - page);
      });
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(child: ElevatedButton(
              onPressed: page <= 0 ? null : () => onMove(-1),
              child: Icon(Icons.arrow_left))
            ),
            SizedBox(width: 10,),
            Expanded(child: ElevatedButton(
              onPressed: page >= lastPage ? null : () => onMove(1),
              child: Icon(Icons.arrow_right))
            )
          ],
        )
      )
    );
  }
}