import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

/// Countdown timer that shows remaining seconds and a tappable
/// "Resend Code" link when the timer expires.
///
/// Usage:
/// ```dart
/// ResendTimerText(
///   durationSeconds: 120,
///   onResend: () => _resendOtp(),
/// )
/// ```
class ResendTimerText extends StatefulWidget {
  final int durationSeconds;
  final VoidCallback? onResend;

  const ResendTimerText({
    super.key,
    this.durationSeconds = 120,
    this.onResend,
  });

  @override
  State<ResendTimerText> createState() => _ResendTimerTextState();
}

class _ResendTimerTextState extends State<ResendTimerText> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remaining = widget.durationSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining > 0) {
        setState(() => _remaining--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_remaining ~/ 60).toString().padLeft(2, '0');
    final s = (_remaining % 60).toString().padLeft(2, '0');
    return '${AppStrings.otpExpirePrefix}$m:${s}s';
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining > 0) {
      return Text(
        _formattedTime,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        widget.onResend?.call();
        _startTimer();
      },
      child: Text(
        AppStrings.resendCode,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
