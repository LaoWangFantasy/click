import 'package:flutter/material.dart';

import 'pages/theme.dart';
import 'pages/dashboard.dart';
import 'pages/profile.dart';

class ClickApp extends StatefulWidget {
  final AppTheme appTheme;

  const ClickApp({super.key, required this.appTheme});

  @override
  State<ClickApp> createState() => _ClickAppState();
}

class _ClickAppState extends State<ClickApp> {
  int _selectedIndex = 0;
  final ValueNotifier<bool> _isClickedNotifier = ValueNotifier<bool>(true);

  void _toggleClick() {
    _isClickedNotifier.value = !_isClickedNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _selectedIndex == 0
              ? DashboardPage(
                  title: "Click or Not",
                  appTheme: widget.appTheme,
                  isClickedNotifier: _isClickedNotifier,
                  onAnimationTriggered: _toggleClick,
                )
              : ProfilePage(title: "My Profile", appTheme: widget.appTheme)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleClick,
        backgroundColor: widget.appTheme.selectedItemColor,
        shape: const CircleBorder(),
        elevation: 5.0,
        child: const Icon(
          Icons.touch_app_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.toggle_off),
            label: 'Toggle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: widget.appTheme.selectedItemColor,
        unselectedItemColor: widget.appTheme.unselectedItemColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: widget.appTheme.gradientMiddleColor,
        elevation: 10,
        type: BottomNavigationBarType.fixed
      ),
    );
  }
}
