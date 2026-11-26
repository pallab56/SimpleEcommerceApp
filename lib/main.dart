import 'package:ecommerceapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:ecommerceapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerceapp/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:ecommerceapp/features/category/presentation/bloc/category_cubit.dart';
import 'package:ecommerceapp/features/home/presentation/bloc/home_cubit.dart';
import 'package:ecommerceapp/features/wishlist/presentation/bloc/wishlist_cubit.dart';
import 'package:ecommerceapp/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'core/route/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(
          create: (_) => serviceLocator<CategoryCubit>()..loadCategories(),
        ),
        BlocProvider(create: (_) => serviceLocator<HomeCubit>()..loadHome()),
        BlocProvider(
          create: (_) => serviceLocator<WishlistCubit>()..loadWishlist(),
        ),
        BlocProvider(create: (_) => serviceLocator<CartCubit>()..loadCart()),
      ],
      child: const CraftyBayApp(),
    ),
  );
}

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
