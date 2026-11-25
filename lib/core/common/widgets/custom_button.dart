import 'package:flutter/material.dart';

/// Full-width elevated button that inherits the global `ElevatedButtonTheme`
/// from [AppTheme] (teal background, white text, 52 px height, rounded 8 px).
///
/// Pass [isLoading] = true to show a spinner and disable taps.
///
/// Usage:
/// ```dart
/// CustomButton(
///   text: AppStrings.next,
///   onPressed: _submit,
/// )
/// ```
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon!,
                      const SizedBox(width: 8),
                      Text(text),
                    ],
                  )
                : Text(text),
      ),
    );
  }
}
