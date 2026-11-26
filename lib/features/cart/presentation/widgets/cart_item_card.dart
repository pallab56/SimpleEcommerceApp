import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final hasNetworkImage = product.imageUrl.startsWith('http');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 82,
                height: 82,
                child: hasNetworkImage
                    ? Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          AppAssets.shoe,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        AppAssets.shoe,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 12),

            // Title, Variants, Price & Quantity Controls
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                  if ((item.color != null && item.color!.isNotEmpty) ||
                      (item.size != null && item.size!.isNotEmpty))
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        [
                          if (item.color != null && item.color!.isNotEmpty)
                            'Color: ${item.color}',
                          if (item.size != null && item.size!.isNotEmpty)
                            'Size: ${item.size}',
                        ].join('  •  '),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _QtyButton(
                            icon: Icons.remove,
                            onTap: onDecrement,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _QtyButton(
                            icon: Icons.add,
                            onTap: onIncrement,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 15, color: Colors.white),
      ),
    );
  }
}
