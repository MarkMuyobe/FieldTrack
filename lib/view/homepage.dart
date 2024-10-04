import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'screens.dart';
import '../model/user.dart';
import '../controller/user_provider.dart';
import 'user_management_page.dart'; // Add this import

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _getPages(UserRole role) {
    final List<Widget> pages = [
      const Dashboard(), // Dashboard page
      const ServiceRequestList(),
    ];

    if (role == UserRole.technician || role == UserRole.manager || role == UserRole.admin) {
      pages.add(const ServiceRequestForm());
    }

    if (role == UserRole.manager || role == UserRole.admin) {
      pages.add(SettingsPage());
    }

    if (role == UserRole.admin) {
      pages.add(const UserManagementPage()); // Replace Calendar with UserManagementPage
    }

    return pages;
  }

  List<Widget> _getNavigationItems(UserRole role) {
    final List<Widget> items = [
      const Icon(Icons.home_filled, size: 30, color: Colors.white),
      const Icon(Icons.list_alt, size: 30, color: Colors.white),
    ];

    if (role == UserRole.technician || role == UserRole.manager || role == UserRole.admin) {
      items.add(const Icon(Icons.add, size: 30, color: Colors.white));
    }

    if (role == UserRole.manager || role == UserRole.admin) {
      items.add(const Icon(Icons.settings, size: 30, color: Colors.white));
    }

    if (role == UserRole.admin) {
      items.add(const Icon(Icons.people, size: 30, color: Colors.white)); // Change icon to represent user management
    }

    return items;
  }

  void _handleLogout(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final User? currentUser = userProvider.user;

    if (currentUser == null) {
      // If there's no user, redirect to login page
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      return Container(); // Return an empty container while redirecting
    }

    final UserRole userRole = currentUser.role;
    final List<Widget> pages = _getPages(userRole);
    final List<Widget> navigationItems = _getNavigationItems(userRole);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00FF7F),
        title: Text(widget.title,
            style: const TextStyle(color: Color(0xFF1E1E1E)),),
        actions: [
          Text('Role: ${userRole.toString().split('.').last}'),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.black,
        buttonBackgroundColor: Colors.green,
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        items: navigationItems,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
