import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(300, 550),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: true,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const ClickApp(title: 'Click Demo'));
}

class ClickApp extends StatelessWidget {
  final String title;

  const ClickApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2C5364),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        extensions: const <ThemeExtension<dynamic>>[
          AppTheme(),
        ],
      ),
      initialRoute: RouteManager.initialRoute,
      onGenerateRoute: RouteManager.onGenerateRoute,
    );
  }
}

class RouteManager {
  static const String initialRoute = '/';
  static const String profilePage = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final appTheme = const AppTheme(); // Create AppTheme here for use in pages
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MainApp(appTheme: appTheme),
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (context) => ProfilePage(
            title: "My Profile",
            appTheme: appTheme,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => MainApp(appTheme: appTheme),
        );
    }
  }
}

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    this.gradientStartColor = const Color(0xFF0F2027),
    this.gradientMiddleColor = const Color(0xFF203A43),
    this.gradientEndColor = const Color(0xFF2C5364),
    this.selectedItemColor = Colors.blueAccent,
    this.unselectedItemColor = Colors.grey,
    this.disabledColor = const Color(0xFF787878),
    this.shadowColor = Colors.black,
  });

  final Color gradientStartColor;
  final Color gradientMiddleColor;
  final Color gradientEndColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color disabledColor;
  final Color shadowColor;

  @override
  AppTheme copyWith({
    Color? gradientStartColor,
    Color? gradientMiddleColor,
    Color? gradientEndColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    Color? disabledColor,
    Color? shadowColor,
  }) {
    return AppTheme(
      gradientStartColor: gradientStartColor ?? this.gradientStartColor,
      gradientMiddleColor: gradientMiddleColor ?? this.gradientMiddleColor,
      gradientEndColor: gradientEndColor ?? this.gradientEndColor,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      disabledColor: disabledColor ?? this.disabledColor,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      gradientStartColor:
          Color.lerp(gradientStartColor, other.gradientStartColor, t)!,
      gradientMiddleColor:
          Color.lerp(gradientMiddleColor, other.gradientMiddleColor, t)!,
      gradientEndColor:
          Color.lerp(gradientEndColor, other.gradientEndColor, t)!,
      selectedItemColor:
          Color.lerp(selectedItemColor, other.selectedItemColor, t)!,
      unselectedItemColor:
          Color.lerp(unselectedItemColor, other.unselectedItemColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }
}

class MainApp extends StatefulWidget {
  final AppTheme appTheme;

  const MainApp({super.key, required this.appTheme});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  final ValueNotifier<bool> _isClickedNotifier = ValueNotifier<bool>(true);

  void _toggleClick() {
    _isClickedNotifier.value = !_isClickedNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _selectedIndex == 0
              ? DashboardPage(
                  title: "Click or Not",
                  appTheme: widget.appTheme,
                  isClickedNotifier: _isClickedNotifier,
                  onAnimationTriggered: _toggleClick,
                )
              : ProfilePage(title: "My Profile", appTheme: widget.appTheme)),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleClick,
        backgroundColor: widget.appTheme.selectedItemColor,
        shape: const CircleBorder(),
        elevation: 5.0,
        child: const Icon(
          Icons.touch_app_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.toggle_off),
            label: 'Toggle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: widget.appTheme.selectedItemColor,
        unselectedItemColor: widget.appTheme.unselectedItemColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: widget.appTheme.gradientMiddleColor,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

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

class ProfilePage extends StatelessWidget {
  final String title;
  final AppTheme appTheme;

  const ProfilePage({super.key, required this.title, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.gradientMiddleColor,
        title: Text(
          title,
          style: TextStyle(
            color: appTheme.selectedItemColor,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Profile Page',
          style: TextStyle(color: appTheme.selectedItemColor, fontSize: 24),
        ),
      ),
    );
  }
}