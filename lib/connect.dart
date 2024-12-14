import 'package:flutter/material.dart';
import 'pages/theme.dart';

class ClickApp extends StatefulWidget {
  final AppTheme appTheme;

  const ClickApp({super.key, required this.appTheme});

  @override
  State<ClickApp> createState() => _ClickAppState();
}

class _ClickAppState extends State<ClickApp> {
  final ValueNotifier<bool> _isClickedNotifier = ValueNotifier<bool>(true);

  void _toggleClick() {
    _isClickedNotifier.value = !_isClickedNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child: Text('You have pressed the button times.'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 10.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleClick,
        backgroundColor: widget.appTheme.selectedItemColor,
        shape: const CircleBorder(),
        // elevation: 5.0,
        child: const Icon(
          Icons.touch_app_rounded,
          // size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
