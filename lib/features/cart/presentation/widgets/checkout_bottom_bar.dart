import 'package:flutter/material.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

/// Bottom bar showing total price + Checkout button.
class CheckoutBottomBar extends StatelessWidget {
  final double total;
  final VoidCallback? onCheckout;

  const CheckoutBottomBar({
    super.key,
    required this.total,
    this.onCheckout,
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
          // Total
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                AppStrings.totalPrice,
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Checkout button
          Expanded(
            child: CustomButton(
              text: AppStrings.checkout,
              onPressed: onCheckout,
            ),
          ),
        ],
      ),
    );
  }
}
