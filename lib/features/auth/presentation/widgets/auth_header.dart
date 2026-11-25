import 'package:flutter/material.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final double logoWidth;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.logoWidth = 90,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppLogo(width: logoWidth),
        const SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
