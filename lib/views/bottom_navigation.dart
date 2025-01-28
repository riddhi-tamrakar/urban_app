import 'package:flutter/material.dart';
import 'routine.dart';
import 'streaks.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // This will hold the current index of the selected tab
  int _selectedIndex = 0;

  // List of Screens to navigate to
  final List<Widget> _screens = [
    RoutineScreen(),  // Routine Screen
    StreaksScreen(),  // Streaks Screen
  ];

  // Function to change the selected tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[
          _selectedIndex], // Display the corresponding screen based on the index
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex, // The current selected tab
        onTap: _onItemTapped, // Set function to handle tab switching
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Routine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Streaks',
          ),
        ],
      ),
    );
  }
}
