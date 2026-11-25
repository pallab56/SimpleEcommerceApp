import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/route/app_router.dart';

/// SplashPage
///
/// Displays the CraftyBay logo with a loading spinner for 2 seconds,
/// then navigates to the login screen (or home if already authenticated).
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // TODO: Check auth state from AppUserCubit to decide destination.
    Navigator.pushReplacementNamed(context, AppRoutes.emailVerification);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Center(child: AppLogo(width: 120)),
              Spacer(),
              CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
              SizedBox(height: 16),
              Text(
                AppStrings.appVersion,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
