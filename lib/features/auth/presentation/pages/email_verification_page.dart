import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/route/app_router.dart';
import '../bloc/password_visibility_cubit.dart';

class EmailVerificationPage extends StatelessWidget {
  EmailVerificationPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  void _onNext(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // TODO: dispatch SendOtp event to AuthBloc
    Navigator.pushNamed(context, AppRoutes.otpVerification);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    const AppLogo(width: 100),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      AppStrings.welcomeBack,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      AppStrings.loginSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Email field
                    CustomTextField(
                      controller: _emailCtrl,
                      hintText: AppStrings.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty)
                              ? AppStrings.enterEmail
                              : null,
                    ),
                    const SizedBox(height: 16),

                    // Password field — eye icon driven by PasswordVisibilityCubit
                    BlocBuilder<PasswordVisibilityCubit, bool>(
                      builder: (ctx, isObscured) => CustomTextField(
                        controller: _passwordCtrl,
                        hintText: AppStrings.passwordHint,
                        obscureText: isObscured,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscured
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          onPressed: () =>
                              ctx.read<PasswordVisibilityCubit>().toggle(),
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty)
                                ? AppStrings.enterPassword
                                : null,
                        onSubmitted: (_) => _onNext(context),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Next button
                    CustomButton(
                      text: AppStrings.next,
                      onPressed: () => _onNext(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
