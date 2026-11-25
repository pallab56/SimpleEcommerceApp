import 'package:flutter/material.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/email_verification_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/complete_profile_page.dart';
import '../../features/main_nav/presentation/pages/main_bottom_nav_page.dart';

/// Centralized named-route constants.
///
/// Every in-app navigation uses these constants so route paths
/// are never hard-coded inside feature code.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String emailVerification = '/email-verification';
  static const String otpVerification = '/otp-verification';
  static const String completeProfile = '/complete-profile';
  static const String mainNav = '/main';
}

/// Centralized route generator.
///
/// Register as `onGenerateRoute` in [MaterialApp].
class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _build(const SplashPage());

      case AppRoutes.emailVerification:
        return _build(const EmailVerificationPage());

      case AppRoutes.otpVerification:
        return _build(const OtpVerificationPage());

      case AppRoutes.completeProfile:
        return _build(const CompleteProfilePage());

      case AppRoutes.mainNav:
        return _build(const MainBottomNavPage());

      default:
        return _build(
          const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }

  static MaterialPageRoute<dynamic> _build(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
