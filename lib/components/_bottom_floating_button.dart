import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:click/status/global.dart';
import 'package:click/theme.dart';

class ClickBottomButton extends StatelessWidget {
  final AppTheme appTheme;

  const ClickBottomButton({
    super.key,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ClickModel>(
      builder: (context, value, child) {
        final isActive = context.read<ClickModel>().isActive();

        return FloatingActionButton(
          onPressed: () {
            context.read<ClickModel>().toggle();
          },
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
