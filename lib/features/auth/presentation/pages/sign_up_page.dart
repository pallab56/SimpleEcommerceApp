import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/utils/snackbar_helper.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/password_visibility_cubit.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_redirect_row.dart';
import '../widgets/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      SnackBarHelper.showError(context, state.message);
    } else if (state is AuthSignUpSuccess) {
      SnackBarHelper.showSuccess(context, state.message);
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.otpVerification,
        arguments: state.email,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordVisibilityCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: _onAuthStateChanged,
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AuthHeader(
                        title: 'Create Account',
                        subtitle: 'Get started with your account details',
                      ),
                      const SizedBox(height: 24),
                      SignUpForm(isLoading: state is AuthLoading),
                      const SizedBox(height: 16),
                      AuthRedirectRow(
                        promptText: 'Already have an account? ',
                        actionText: 'Login',
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
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
