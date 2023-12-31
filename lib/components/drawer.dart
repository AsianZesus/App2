import 'package:flood_app/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onLogOutTap;
  final void Function()? onSettingsTap;

  const MyDrawer({super.key,
  required this.onLogOutTap,
  required this.onSettingsTap});

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

          MyListTile(icon: Icons.settings, text: "S E T T I N G S", 
          onTap: onSettingsTap),

          MyListTile(icon: Icons.logout, 
          text: "L O G O U T", 
          onTap: onLogOutTap)

        ]),
    );
  }
}