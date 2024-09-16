import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'dashboard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const Dashboard(),
    const Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Add', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Calendar', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Settings', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FieldTrack',style: TextStyle(fontSize: 12),),
        backgroundColor: Colors.green[700],
      ),
      body: _pages[_selectedIndex],
      // Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,  // The color of the page background
        color: Colors.black,  // The color of the curved bar
        buttonBackgroundColor: Colors.green,  // The background color of the selected button
        animationDuration: const Duration(milliseconds: 300),  // Animation duration
        height: 60,  // Height of the curved bar
        items: const <Widget>[
          Icon(Icons.home_filled, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),  // Icon for add Item
          Icon(Icons.calendar_today, size: 30, color: Colors.white),  // Icon for Calendar
          Icon(Icons.settings, size: 30, color: Colors.white),  // Icon for Settings
        ],
        onTap: (index) {
          setState((){
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

