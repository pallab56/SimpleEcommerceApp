import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/route/app_router.dart';
import '../widgets/otp_pin_field.dart';
import '../widgets/resend_timer_text.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  // Plain field — OTP is a transient value, no Cubit rebuild needed
  String _otp = '';

  void _onVerify() {
    if (_otp.length < 4) return;
    // TODO: dispatch VerifyOtp event to AuthBloc
    Navigator.pushNamed(context, AppRoutes.completeProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                const AppLogo(width: 100),
                const SizedBox(height: 24),

                // Title
                Text(
                  AppStrings.enterOtpTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  AppStrings.enterOtpSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),

                // 4-digit OTP boxes
                OtpPinField(onCompleted: (otp) => _otp = otp),
                const SizedBox(height: 24),

                // Verify button
                CustomButton(
                  text: AppStrings.next,
                  onPressed: _onVerify,
                ),
                const SizedBox(height: 24),

                // Countdown / Resend
                ResendTimerText(
                  durationSeconds: 120,
                  onResend: () {
                    // TODO: dispatch ResendOtp event to AuthBloc
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
