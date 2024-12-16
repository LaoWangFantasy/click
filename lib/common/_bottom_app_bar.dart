import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:click/status/global.dart';

class ClickBottomAppBar extends StatelessWidget {
  const ClickBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (ctx, g, _) {
        final theme = g.theme;

        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          color: theme.gradientMiddleColor,
          elevation: 10,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildItem(context, g, 0, Icons.dashboard, 'Dashboard'),
                const SizedBox(width: 50),
                _buildItem(context, g, 1, Icons.account_circle_sharp, 'Profile'),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildItem(BuildContext ctx, GlobalModel g, int idx, IconData icon, String tooltip) {
  final isSelected = g.isSelected(idx);

  return IconButton(
    onPressed: () => g.setIndex(idx),
    icon: Icon(
      icon,
      color: isSelected ? Colors.amber : Colors.white,
    ),
    tooltip: tooltip,
  );
}
