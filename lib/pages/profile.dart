import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:click/status/global.dart';
import 'package:click/common/_theme.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  final AppTheme appTheme;

  const ProfilePage({
    super.key,
    required this.title,
    required this.appTheme,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
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
        final isActive = context.watch<GlobalModel>().isActivate();

        // Trigger animation based on isActive state
        if (isActive && _animationController.status != AnimationStatus.forward) {
          _animationController.forward();
        } else if (!isActive && _animationController.status != AnimationStatus.reverse) {
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
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      SizedBox(height: screenHeight * 0.02),
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _animation.value,
                            child: CircleAvatar(
                              radius: screenWidth * 0.2,
                              backgroundColor: widget.appTheme.shadowColor,
                              backgroundImage: const AssetImage('assets/profile.jpg'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        "John Doe", // Placeholder for the user name
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "johndoe@example.com", // Placeholder for the user email
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProfileOption(
                              context,
                              icon: Icons.person,
                              title: "Account Details",
                              screenWidth: screenWidth,
                            ),
                            _buildProfileOption(
                              context,
                              icon: Icons.settings,
                              title: "Settings",
                              screenWidth: screenWidth,
                            ),
                            _buildProfileOption(
                              context,
                              icon: Icons.logout,
                              title: "Log Out",
                              screenWidth: screenWidth,
                              isDestructive: true,
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double screenWidth,
    bool isDestructive = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        children: [
          Icon(
            icon,
            color: isDestructive ? Colors.redAccent : Colors.white,
            size: screenWidth * 0.06,
          ),
          SizedBox(width: screenWidth * 0.04),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: isDestructive ? Colors.redAccent : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
