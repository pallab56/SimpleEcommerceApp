import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

/// SplashPage
///
/// Layout (matches CraftyBay UI mockup):
///  - Centered column
///  - Spacer → Logo (120 px) → Spacer
///  - CircularProgressIndicator (primary teal, strokeWidth 3)
///  - 16 px gap
///  - Version label (12 px, grey)
///
/// After a 2-second delay it navigates to EmailVerificationPage or
/// MainBottomNavPage via AppRouter (wired up in init_dependencies /
/// app_router.dart — replace the TODO below once routing is configured).
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
    // TODO: Replace with GoRouter navigation once AppRouter is configured.
    // context.go(AppRoutes.emailVerification);  // unauthenticated
    // context.go(AppRoutes.home);               // authenticated
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
              // ── Logo centred vertically ──────────────────────────────────
              Spacer(),
              Center(child: AppLogo(width: 120)),
              Spacer(),

              // ── Loading indicator ────────────────────────────────────────
              CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
              SizedBox(height: 16),

              // ── Version label ────────────────────────────────────────────
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
