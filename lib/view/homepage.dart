import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dashboard.dart'; // Import the Dashboard screen

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    Dashboard(), // Dashboard page
    const Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Add', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Calendar', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Settings', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      // Bottom Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent, // Background behind the bar
        color: Colors.black, // Curved navigation bar color
        buttonBackgroundColor: Colors.green, // Selected button background color
        animationDuration: const Duration(milliseconds: 300), // Animation duration
        height: 60, // Curved bar height
        items: const <Widget>[
          Icon(Icons.home_filled, size: 30, color: Colors.white), // Home icon
          Icon(Icons.notifications, size: 30, color: Colors.white), // Notifications icon
          Icon(Icons.add, size: 30, color: Colors.white), // Add icon
          Icon(Icons.calendar_today, size: 30, color: Colors.white), // Calendar icon
          Icon(Icons.settings, size: 30, color: Colors.white), // Settings icon
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}
