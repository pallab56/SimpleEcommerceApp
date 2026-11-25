import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Row of circular color swatches.
class ColorSelector extends StatelessWidget {
  static const colors = [
    Color(0xFF000000),
    Color(0xFF607D8B),
    Color(0xFF795548),
    Color(0xFF2196F3),
  ];

  final Color selectedColor;
  final ValueChanged<Color> onSelect;

  const ColorSelector({
    super.key,
    required this.selectedColor,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: colors.map((c) {
        final isSelected = c == selectedColor;
        return GestureDetector(
          onTap: () => onSelect(c),
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: c,
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
