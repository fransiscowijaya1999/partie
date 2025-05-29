import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({ super.key });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text('Partie'),
          ),
          ListTile(
            title: Text('Vehicles'),
          ),
          ListTile(
            title: Text('Parts'),
          )
        ],
      ),
    );
  }
}