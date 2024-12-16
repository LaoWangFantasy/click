import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/init_window.dart';
import 'status/global.dart';
import 'app.dart';

void main() {
  setupWindow();
  runApp(const ClickCore(title: 'Click Demo'));
}

class ClickCore extends StatelessWidget {
  final String title;
  const ClickCore({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalModel()),
      ],
      child: ClickApp(title: title)
    );
  }
}
