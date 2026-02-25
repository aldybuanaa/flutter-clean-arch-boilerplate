import 'package:flutter/material.dart';

/// Extension on [BuildContext] for convenient access to theme, media query,
/// navigation, and snackbar utilities.
extension ContextExtensions on BuildContext {
  // ─── Theme ───────────────────────────────────────────────────────────────

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // ─── Screen info ─────────────────────────────────────────────────────────

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  bool get isKeyboardOpen => MediaQuery.of(this).viewInsets.bottom > 0;

  // ─── Navigation ──────────────────────────────────────────────────────────

  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.of(
      this,
    ).pushReplacement<T, void>(MaterialPageRoute(builder: (_) => page));
  }

  // ─── SnackBar ────────────────────────────────────────────────────────────

  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          backgroundColor: backgroundColor,
          action: action,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: colorScheme.error);
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }
}
