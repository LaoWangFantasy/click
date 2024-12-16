import 'package:flutter/material.dart';
import 'package:click/theme.dart';

class ProfilePage extends StatelessWidget {
  final String title;
  final AppTheme appTheme;

  const ProfilePage({super.key, required this.title, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.gradientMiddleColor,
        title: Text(
          title,
          style: TextStyle(
            color: appTheme.selectedItemColor,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Profile Page',
          style: TextStyle(color: appTheme.selectedItemColor, fontSize: 24),
        ),
      ),
    );
  }
}