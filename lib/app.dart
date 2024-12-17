import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/_bottom_app_bar.dart';
import 'common/_bottom_floating_button.dart';

import 'status/global.dart';
import 'pages/dashboard.dart';
import 'pages/profile.dart';

class ClickApp extends StatelessWidget {
  final String title;

  const ClickApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (ctx, g, _) => ClickAppBuilder.build(ctx, g, title)
    );
  }
}

class ClickAppBuilder {
  static Widget build(BuildContext ctx, GlobalModel g, String title) {
    final theme = g.theme;
    final index = g.selectedIndex;

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: theme.darkTheme,
      home: Scaffold(
        body: _buildPage(index),
        floatingActionButton: ClickBottomButton(),
        floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ClickBottomAppBar(),
      ),
    );
  }
}

Widget _buildPage(int index) {
  switch (index) {
    case 0:
      return DashboardPage(title: "Dashboard");
    case 1:
      return ProfilePage(title: "Profile");
    default:
      return DashboardPage(title: "Dashboard");
  }
}