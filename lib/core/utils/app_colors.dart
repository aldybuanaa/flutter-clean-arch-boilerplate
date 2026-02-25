import 'package:flutter/material.dart';

/// Centralized color definitions for the application.
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color onPrimary = Colors.white;

  // Secondary
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color onSecondary = Colors.black;

  // Background
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color onBackground = Colors.black;
  static const Color onSurface = Colors.black;

  // Error
  static const Color error = Color(0xFFB00020);
  static const Color onError = Colors.white;

  // Dark theme
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkOnBackground = Colors.white;
  static const Color darkOnSurface = Colors.white;
}
