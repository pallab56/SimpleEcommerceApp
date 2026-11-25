import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// [-] count [+] stepper used in Product Details and Cart.
///
/// Usage:
/// ```dart
/// QuantityStepper(
///   quantity: qty,
///   onDecrement: () {},
///   onIncrement: () {},
/// )
/// ```
class QuantityStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepBtn(icon: Icons.remove, onTap: quantity > 1 ? onDecrement : null),
        Container(
          width: 36,
          alignment: Alignment.center,
          child: Text(
            quantity.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        _StepBtn(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _StepBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: onTap != null ? AppColors.primaryLight : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: onTap != null ? AppColors.primary : AppColors.textHint,
        ),
      ),
    );
  }
}
