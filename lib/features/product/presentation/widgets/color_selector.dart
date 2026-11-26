import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<String> colors;
  final String? selectedColor;
  final ValueChanged<String> onColorSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (colors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: colors.map((color) {
            return ChoiceChip(
              label: Text(color),
              selected: selectedColor == color,
              onSelected: (_) => onColorSelected(color),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
