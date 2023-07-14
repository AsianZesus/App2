import 'package:flood_app/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onAboutTap;
  final void Function()? onLogOutTap;

  const MyDrawer({super.key,
  required this.onAboutTap,
  required this.onLogOutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          const DrawerHeader(child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
            ),
          ),

          MyListTile(icon: Icons.priority_high_rounded, 
          text: 'A B O U T',
          onTap: onAboutTap),

          MyListTile(icon: Icons.logout, 
          text: "L O G O U T", 
          onTap: onLogOutTap)

        ]),
    );
  }
}