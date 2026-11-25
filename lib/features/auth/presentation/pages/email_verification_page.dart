import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/route/app_router.dart';

/// Email + Password login screen.
///
/// Layout (matches CraftyBay mockup):
///  - AppLogo centred at top
///  - "Welcome Back" headline
///  - Subtitle
///  - Email text field
///  - Password text field (obscured)
///  - "Next" button
class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onNext() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // TODO: Dispatch login event to AuthBloc
    Navigator.pushNamed(context, AppRoutes.otpVerification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Logo ────────────────────────────────────────────────
                  const AppLogo(width: 100),
                  const SizedBox(height: 24),

                  // ── Title & subtitle ────────────────────────────────────
                  Text(
                    AppStrings.welcomeBack,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    AppStrings.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Email field ─────────────────────────────────────────
                  CustomTextField(
                    controller: _emailCtrl,
                    hintText: AppStrings.emailHint,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // ── Password field ──────────────────────────────────────
                  CustomTextField(
                    controller: _passwordCtrl,
                    hintText: AppStrings.passwordHint,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSubmitted: (_) => _onNext(),
                  ),
                  const SizedBox(height: 24),

                  // ── Next button ─────────────────────────────────────────
                  CustomButton(
                    text: AppStrings.next,
                    onPressed: _onNext,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
