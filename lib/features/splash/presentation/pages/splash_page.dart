import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/route/app_router.dart';
import '../../../../init_dependencies.dart';
import '../bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<SplashBloc>()..add(const CheckAuthStatusEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            Navigator.pushReplacementNamed(context, AppRoutes.mainNav);
          } else if (state is SplashUnauthenticated) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.emailVerification,
            );
          }
        },
        child: const Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  AppLogo(width: 120),
                  Spacer(),
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Version 1.0.0'),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
