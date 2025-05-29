import 'package:flutter/material.dart';
import 'package:partie/components/nav_drawer.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton
  });

  final String title;
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      drawer: NavDrawer(),
      body: body,
      floatingActionButton: floatingActionButton
    );
  }
}