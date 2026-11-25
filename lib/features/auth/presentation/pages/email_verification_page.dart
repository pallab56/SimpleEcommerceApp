import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/password_visibility_cubit.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<AuthBloc>().add(
          AuthLoginEvent(
            email: _emailCtrl.text.trim(),
            password: _passwordCtrl.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                SnackBarHelper.showError(context, state.message);
              } else if (state is AuthSuccess) {
                if (!state.user.emailVerified) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.otpVerification,
                    arguments: state.user.email,
                  );
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.mainNav, // Replace with your home/bottomNav route name
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

                        // Password field
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
                            onSubmitted: (_) => _onLogin(),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Login / Next button
                        CustomButton(
                          text: AppStrings.next,
                          isLoading: isLoading,
                          onPressed: isLoading ? null : _onLogin,
                        ),
                        const SizedBox(height: 16),

                        // Navigate to Sign Up
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.signUp,
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
