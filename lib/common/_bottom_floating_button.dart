import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:click/status/global.dart';

class ClickBottomButton extends StatelessWidget {
  const ClickBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (ctx, g, _) => ClickBottomButtonBuilder.build(ctx, g),
    );
  }
}

class ClickBottomButtonBuilder {
  static Widget build(BuildContext context, GlobalModel globalModel) {
    final isActive = globalModel.isActivate;
    final appTheme = globalModel.theme;

    return FloatingActionButton(
      onPressed: globalModel.toggleActivate,
      backgroundColor: appTheme.selectedItemColor,
      shape: const CircleBorder(),
      elevation: 5.0,
      child: Icon(
        isActive ? Icons.stop : Icons.power_settings_new,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}