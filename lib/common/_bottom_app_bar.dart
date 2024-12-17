import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:click/status/global.dart';

class ClickBottomAppBar extends StatelessWidget {
  const ClickBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (ctx, g, _) => ClickBottomAppBarBuilder.build(ctx, g),
    );
  }
}

class ClickBottomAppBarBuilder {
  static Widget build(BuildContext ctx, GlobalModel g) {
    final theme = g.theme;
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: theme.gradientMiddleColor,
      elevation: 10,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(ctx).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildItem(ctx, g, 0, Icons.dashboard, 'Dashboard'),
            const SizedBox(width: 50),
            _buildItem(ctx, g, 1, Icons.account_circle_sharp, 'Profile'),
          ],
        ),
      ),
    );
  }

  static Widget _buildItem(BuildContext ctx, GlobalModel g, int idx, IconData icon, String tooltip) {
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
}