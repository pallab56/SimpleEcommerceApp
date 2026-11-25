import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AuthRedirectRow extends StatelessWidget {
  final String promptText;
  final String actionText;
  final VoidCallback onTap;

  const AuthRedirectRow({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
