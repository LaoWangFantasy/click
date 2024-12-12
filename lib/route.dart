import 'package:flutter/material.dart';

import 'pages/theme.dart';
import 'pages/dashboard.dart';
import 'pages/profile.dart';
import 'app.dart';


class RouteManager {
  static const String initialRoute = '/';
  static const String profilePage = '/profile';
  static const String dashboardPage = '/dashboard';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final appTheme = const AppTheme(); // Create AppTheme here for use in pages
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => ClickApp(appTheme: appTheme),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(
            title: "My Profile",
            appTheme: appTheme,
          ),
        );
      case dashboardPage:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(
            title: "My Profile",
            appTheme: appTheme,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => ClickApp(appTheme: appTheme),
        );
    }
  }
}