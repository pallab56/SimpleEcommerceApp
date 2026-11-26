import 'package:flutter/material.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/theme/app_colors.dart';

class CheckoutBottomBar extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onCheckout;

  const CheckoutBottomBar({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 150,
            child: CustomButton(
              text: 'Checkout',
              onPressed: onCheckout,
            ),
          ),
        ],
      ),
    );
  }
}
