import 'package:flutter/material.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/email_verification_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/complete_profile_page.dart';
import '../../features/main_nav/presentation/pages/main_bottom_nav_page.dart';
import '../../features/category/presentation/pages/categories_page.dart';
import '../../features/category/presentation/pages/category_products_page.dart';
import '../../core/common/entities/category.dart';

/// All named-route path constants for the app.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String emailVerification = '/email-verification';
  static const String otpVerification = '/otp-verification';
  static const String completeProfile = '/complete-profile';
  static const String mainNav = '/main';
  static const String categories = '/categories';
  static const String categoryProducts = '/category-products';
  static const String productDetails = '/product-details';
}

/// Centralized route generator — register as [MaterialApp.onGenerateRoute].
class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _build(const SplashPage());

      case AppRoutes.emailVerification:
        return _build(EmailVerificationPage());

      case AppRoutes.otpVerification:
        return _build(OtpVerificationPage());

      case AppRoutes.completeProfile:
        return _build(CompleteProfilePage());

      case AppRoutes.mainNav:
        return _build(const MainBottomNavPage());

      case AppRoutes.categories:
        return _build(const CategoriesPage());

      case AppRoutes.categoryProducts:
        final category = settings.arguments as Category;
        return _build(CategoryProductsPage(category: category));

      case AppRoutes.productDetails:
        // TODO: wire up product details page when implemented
        return _build(
          const Scaffold(
            body: Center(child: Text('Product Details — coming soon')),
          ),
        );

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
