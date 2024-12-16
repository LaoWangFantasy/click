import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:click/status/global.dart';
import 'package:click/common/_theme.dart';

class DashboardPage extends StatefulWidget {
  final String title;
  final AppTheme appTheme;

  const DashboardPage({
    super.key,
    required this.title,
    required this.appTheme,
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
      duration: const Duration(milliseconds: 200), // Changed the duration
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.9, end: 1.2).animate(
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

    return Consumer<GlobalModel>(
      builder: (context, value, child) {
        final isClicked = context.watch<GlobalModel>().isActivate();

        // Trigger animation based on isClicked change
        if (isClicked && _animationController.status != AnimationStatus.forward) {
            _animationController.forward();
        } else if (!isClicked && _animationController.status != AnimationStatus.reverse) {
          _animationController.reverse();
        }

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
                  boxShadow: [
                    BoxShadow(
                      color: widget.appTheme.shadowColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
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
                                          ? widget.appTheme.selectedItemColor.withOpacity(0.5)
                                          : Colors.redAccent.withOpacity(0.5),
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
                            isClicked ? 'Connected' : 'Disconnected',
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
                                ? 'The connection status is true'
                                : 'The connection status is false',
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
    });
  }
}