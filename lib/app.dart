import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/_bottom_app_bar.dart';
import 'common/_bottom_floating_button.dart';

import 'status/global.dart';
import 'pages/dashboard.dart';
import 'pages/profile.dart';

class ClickApp extends StatefulWidget {
  final String title;
  const ClickApp({super.key, required this.title});
  @override
  State<ClickApp> createState() => _ClickAppState();
}

class _ClickAppState extends State<ClickApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (ctx, g, _) {
        final appTheme = g.theme;

        return MaterialApp(
          title: widget.title,
          debugShowCheckedModeBanner: false,
          theme: appTheme.darkTheme, // Use the theme dynamically
          home: Scaffold(
            body: _buildPage(ctx, g),
            floatingActionButton: ClickBottomButton(),
            floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: ClickBottomAppBar(),
          ),
        );
      },
    );
  }
}

Widget _buildPage(BuildContext ctx, GlobalModel g) {
  final index = g.selectedIndex;
  final theme = g.theme;
  switch (index) {
    case 0:
      return DashboardPage(title: "Dashboard", appTheme: theme);
    case 1:
      return ProfilePage(title: "Profile", appTheme: theme);
    default:
      return DashboardPage(title: "Dashboard", appTheme: theme);
  }
}
