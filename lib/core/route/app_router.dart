import 'package:ecommerceapp/core/common/entities/category.dart';
import 'package:ecommerceapp/core/common/entities/product.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/complete_profile_page.dart';
import '../../features/auth/presentation/pages/email_verification_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/category/presentation/pages/categories_page.dart';
import '../../features/category/presentation/pages/category_products_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/main_nav/presentation/pages/main_bottom_nav_page.dart';
import '../../features/product/presentation/pages/create_review_page.dart';
import '../../features/product/presentation/pages/product_details_page.dart';
import '../../features/product/presentation/pages/product_reviews_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String emailVerification = '/email-verification';
  static const String signUp = '/sign-up';
  static const String otpVerification = '/otp-verification';
  static const String completeProfile = '/complete-profile';
  static const String mainNav = '/main-nav';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String categoryProducts = '/category-products';
  static const String productDetails = '/product-details';
  static const String productReviews = '/product-reviews';
  static const String createReview = '/create-review';
  static const String cart = '/cart';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashPage(),
        );

      case AppRoutes.emailVerification:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const EmailVerificationPage(),
        );

      case AppRoutes.signUp:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SignUpPage(),
        );

      case AppRoutes.otpVerification:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OtpVerificationPage(email: email),
        );

      case AppRoutes.completeProfile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CompleteProfilePage(),
        );

      case AppRoutes.mainNav:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainBottomNavPage(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );

      case AppRoutes.categories:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CategoriesPage(),
        );

      case AppRoutes.categoryProducts:
        final category = settings.arguments as Category;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CategoryProductsPage(category: category),
        );

      case AppRoutes.productDetails:
        final args = settings.arguments;
        final productId = args is Product
            ? args.id
            : (args is String ? args : '');
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetailsPage(productId: productId),
        );

      case AppRoutes.productReviews:
        final productId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductReviewsPage(productId: productId),
        );

      case AppRoutes.createReview:
        final productId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CreateReviewPage(productId: productId),
        );

      case AppRoutes.cart:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CartPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
