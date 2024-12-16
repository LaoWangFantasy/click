import 'package:flutter/material.dart';
import 'package:click/theme.dart';

class ClickBottomAppBar extends StatelessWidget {
  final AppTheme appTheme;

  const ClickBottomAppBar({
    super.key,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: appTheme.gradientMiddleColor,
      elevation: 10,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dashboard, color: Colors.white),
              tooltip: 'Dashboard',
            ),
            const SizedBox(width: 50), // Space for the notch
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_sharp, color: Colors.white),
              tooltip: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6.0,
//         color: widget.appTheme.gradientMiddleColor,
//         elevation: 10,
//         child: SizedBox(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.dashboard, color: Colors.white),
//               ),
//               const SizedBox(width: 50), // Space for the notch
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.account_circle_sharp, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
      // BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle_sharp),
      //       label: 'Profile',
      //     ),
      //   ],
      //   selectedItemColor: widget.appTheme.selectedItemColor,
      //   unselectedItemColor: widget.appTheme.unselectedItemColor,
      //   backgroundColor: widget.appTheme.gradientMiddleColor,
      //   elevation: 10,
      //   type: BottomNavigationBarType.fixed
      // ),
