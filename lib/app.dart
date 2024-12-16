import 'package:flutter/material.dart';
import 'components/_bottom_app_bar.dart';
import 'components/_bottom_floating_button.dart';

import 'pages/dashboard.dart';
import 'package:click/theme.dart';

class ClickApp extends StatefulWidget {
  final String title;
  final AppTheme appTheme;

  const ClickApp({super.key, required this.title, required this.appTheme});

  @override
  State<ClickApp> createState() => _ClickAppState();
}

class _ClickAppState extends State<ClickApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: widget.title,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: DashboardPage(title: "Click or Not", appTheme: widget.appTheme),
          floatingActionButton: ClickBottomButton(appTheme: widget.appTheme),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: ClickBottomAppBar(appTheme: widget.appTheme),
        ),
        theme: AppTheme.darkTheme);
  }
}
