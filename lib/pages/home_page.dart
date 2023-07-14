import 'package:flood_app/components/bottom_nav_bar.dart';
import 'package:flood_app/pages/dash_page.dart';
import 'package:flood_app/pages/map_page.dart';
import 'package:flood_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Navigate bottom nav bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //final
  final List<Widget> _pages = [
    // Home page
    DashPage(),

    // Map page
    MapPage(),

    // Settings page
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // dynamic conversationObject = {
          //   'appId':
          //       '238886987f58a2f798d03876520abea92', // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
          // };

          // KommunicateFlutterPlugin.buildConversation(conversationObject)
          //     .then((clientConversationId) {
          //   print("Conversation builder success : " +
          //       clientConversationId.toString());
          // }).catchError((error) {
          //   print("Conversation builder error : " + error.toString());
          // });
        },
        child: Icon(Icons.chat,
        color: Colors.black,),
      ),
    );
  }
}
