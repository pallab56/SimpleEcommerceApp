import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Row of size chips (S / M / L / XL).
/// Calls [onSelect] when a chip is tapped.
class SizeSelector extends StatelessWidget {
  static const sizes = ['S', 'M', 'L', 'XL'];

  final String selectedSize;
  final ValueChanged<String> onSelect;

  const SizeSelector({
    super.key,
    required this.selectedSize,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: sizes.map((s) {
        final isSelected = s == selectedSize;
        return GestureDetector(
          onTap: () => onSelect(s),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.primary : AppColors.background,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Text(
              s,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color:
                    isSelected ? AppColors.white : AppColors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
