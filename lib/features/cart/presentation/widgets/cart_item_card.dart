import 'package:flutter/material.dart';
import '../../../../core/common/widgets/quantity_stepper.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/cart_item.dart';

/// Horizontal product card shown inside CartPage.
///
/// Layout: image | title + size + price | stepper + delete
class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Shoe image ─────────────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              AppAssets.shoe,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // ── Info ───────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (item.selectedSize != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Size: ${item.selectedSize}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  '\$${item.product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // ── Stepper + delete ───────────────────────────────────────────
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.delete_outline,
                    size: 20, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 12),
              QuantityStepper(
                quantity: item.quantity,
                onDecrement: onDecrement,
                onIncrement: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
