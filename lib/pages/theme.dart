import 'package:flutter/material.dart';

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