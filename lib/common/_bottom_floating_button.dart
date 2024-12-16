import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:click/status/global.dart';

class ClickBottomButton extends StatelessWidget {
  const ClickBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (ctx, g, _) {
        final isActive = g.isActivate();
        final appTheme = g.theme;

        return FloatingActionButton(
          onPressed: g.toggleActivate,
          backgroundColor: appTheme.selectedItemColor,
          shape: const CircleBorder(),
          elevation: 5.0,
          child: Icon(
            isActive? Icons.stop:Icons.power_settings_new,
            size: 28,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
