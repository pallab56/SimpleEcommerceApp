import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Standard back-button + title app bar used on inner screens
/// (Complete Profile, Product Details, Reviews, Cart, etc.).
///
/// Usage:
/// ```dart
/// Scaffold(
///   appBar: CustomAppBar(title: AppStrings.completeProfileTitle),
///   body: ...,
/// )
/// ```
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              color: AppColors.textPrimary,
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,
      automaticallyImplyLeading: showBackButton,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: actions,
    );
  }
}
