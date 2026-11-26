import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class QuantityControls extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const QuantityControls({
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
        _buildButton(icon: Icons.remove, onTap: onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _buildButton(icon: Icons.add, onTap: onIncrement),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}
