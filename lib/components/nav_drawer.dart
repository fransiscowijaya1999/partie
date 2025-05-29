import 'package:flutter/material.dart';
import 'package:partie/screens/items_screen.dart';
import 'package:partie/screens/vehicles_screen.dart';

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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const VehiclesScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Items'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ItemsScreen()),
              );
            },
          )
        ],
      ),
    );
  }
}