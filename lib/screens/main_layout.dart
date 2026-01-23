import 'package:flutter/material.dart';
import 'package:green_fields/screens/profile.dart';
import 'package:green_fields/screens/request_pickup_screen.dart';
import 'package:green_fields/screens/schedule_screen.dart';
import 'home_screen.dart';
import 'pickup_history_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    RequestPickupScreen(),
    ScheduleScreen(),
    ProfileScreen(),

    ///  ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Request Pickup",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Pickup History",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
