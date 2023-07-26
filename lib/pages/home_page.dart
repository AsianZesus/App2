import 'package:flood_app/components/bottom_nav_bar.dart';
import 'package:flood_app/pages/chat_page.dart';
import 'package:flood_app/pages/dash_page.dart';
import 'package:flood_app/pages/map_page.dart';
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
    const DashPage(),

    // Map page
    const MapPage(),

    // Chat page
    const ChatbotScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
