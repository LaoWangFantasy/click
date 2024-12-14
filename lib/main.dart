import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'pages/theme.dart';
import 'route.dart';
// import 'connect.dart';


void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(300, 550),
      center: true,
      backgroundColor: Colors.greenAccent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.normal,
      windowButtonVisibility: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const ClickCore(title: 'Click Demo'));
}

class ClickCore extends StatelessWidget {
  final String title;
  final appTheme = const AppTheme();

  const ClickCore({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      // home: ClickApp(appTheme: appTheme),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C5364),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        extensions: const <ThemeExtension<dynamic>>[
          AppTheme(),
        ],
      ),
      initialRoute: RouteManager.initialRoute,
      onGenerateRoute: RouteManager.onGenerateRoute,
    );
  }
}


