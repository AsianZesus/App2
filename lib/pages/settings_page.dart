import 'package:flood_app/pages/about_page.dart';
import 'package:flood_app/pages/change_password.dart';
import 'package:flood_app/pages/events.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key,});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          _buildOptionItem(context, 'About', AboutPage()),
          _buildOptionItem(context, 'Saved Alerts', NotificationsPage()),
          _buildOptionItem(context, 'Change Password', ChangePasswordPage()),

        ],
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, String title, Widget screen) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
