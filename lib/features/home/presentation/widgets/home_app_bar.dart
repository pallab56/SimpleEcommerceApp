import 'package:ecommerceapp/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/common/widgets/app_logo.dart';
import '../../../../core/theme/app_colors.dart';

/// Home screen app bar — CraftyBay logo on the left, action icons on the right.
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      elevation: 0,
      title:  SvgPicture.asset(AppAssets.appLogoNav),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline,
              color: AppColors.textPrimary, size: 24),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.phone_outlined,
              color: AppColors.textPrimary, size: 24),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none,
              color: AppColors.textPrimary, size: 24),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
