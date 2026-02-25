import 'package:flutter/material.dart';

/// Reusable elevated button with loading state support.
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? leadingIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.leadingIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 12.0,
    this.padding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                foregroundColor ?? colorScheme.onPrimary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(label),
            ],
          );

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? colorScheme.primary,
        foregroundColor: foregroundColor ?? colorScheme.onPrimary,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: child,
    );

    if (width != null) {
      return SizedBox(width: width, child: button);
    }
    return button;
  }
}
