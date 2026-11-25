import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/otp_pin_field.dart';
import '../widgets/resend_timer_text.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;

  const OtpVerificationPage({
    super.key,
    required this.email,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  // Plain field — OTP is a transient value, no Cubit rebuild needed
  String _otp = '';

  void _onVerify() {
    if (_otp.length < 4) {
      SnackBarHelper.showError(context, 'Please enter the 4-digit OTP');
      return;
    }

    context.read<AuthBloc>().add(
          AuthVerifyOtpEvent(
            email: widget.email,
            otp: _otp,
          ),
        );
  }

  void _onResend() {
    context.read<AuthBloc>().add(
          AuthSendOtpEvent(email: widget.email),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              SnackBarHelper.showError(context, state.message);
            } else if (state is AuthOtpSentSuccess) {
              SnackBarHelper.showSuccess(context, state.message);
            } else if (state is AuthSuccess) {
              SnackBarHelper.showSuccess(
                context,
                'Email verified successfully',
              );

              if (state.user.firstName.isEmpty) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.completeProfile,
                  (_) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.mainNav,
                  (_) => false,
                );
              }
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Center(
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
                    OtpPinField(
                      onCompleted: (otp) {
                        _otp = otp;
                        _onVerify();
                      },
                    ),
                    const SizedBox(height: 24),

                    // Verify button
                    CustomButton(
                      text: AppStrings.next,
                      isLoading: isLoading,
                      onPressed: isLoading ? null : _onVerify,
                    ),
                    const SizedBox(height: 24),

                    // Countdown / Resend
                    ResendTimerText(
                      durationSeconds: 120,
                      onResend: _onResend,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
