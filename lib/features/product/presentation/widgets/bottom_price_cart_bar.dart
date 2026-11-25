import 'package:flutter/material.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

/// Price + "Add To Cart" bottom action bar on Product Details page.
class BottomPriceCartBar extends StatelessWidget {
  final double price;
  final VoidCallback? onAddToCart;

  const BottomPriceCartBar({
    super.key,
    required this.price,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Price',
                  style: TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 2),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: CustomButton(
              text: AppStrings.addToCart,
              onPressed: onAddToCart,
            ),
          ),
        ],
      ),
    );
  }
}
