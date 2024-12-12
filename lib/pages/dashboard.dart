import 'package:flutter/material.dart';

import 'theme.dart';

class DashboardPage extends StatefulWidget {
  final String title;
  final AppTheme appTheme;
  final ValueNotifier<bool> isClickedNotifier;
  final VoidCallback onAnimationTriggered;

  const DashboardPage({
    super.key,
    required this.title,
    required this.appTheme,
    required this.isClickedNotifier,
    required this.onAnimationTriggered,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool shouldAnimate = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return ValueListenableBuilder<bool>(
      valueListenable: widget.isClickedNotifier,
      builder: (context, isClicked, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.appTheme.gradientStartColor,
                        widget.appTheme.gradientMiddleColor,
                        widget.appTheme.gradientEndColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: !isClicked
                        ? [
                            BoxShadow(
                              color:
                                  widget.appTheme.shadowColor.withValues(alpha: 0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.03,
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: screenWidth * 0.3,
                                  height: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: isClicked
                                            ? widget.appTheme.selectedItemColor
                                                .withValues(alpha: 0.5)
                                            : Colors.redAccent.withValues(alpha: 0.5),
                                        spreadRadius: 10,
                                        blurRadius: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _animation.value,
                                      child: Icon(
                                        Icons.shield_rounded,
                                        size: screenWidth * 0.25,
                                        color: isClicked
                                            ? widget.appTheme.selectedItemColor
                                            : Colors.redAccent,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              isClicked ? 'Clicked' : 'UnClicked',
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                color: isClicked
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              isClicked
                                  ? 'The click status is true'
                                  : 'The click status is false',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey[300],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.15),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}