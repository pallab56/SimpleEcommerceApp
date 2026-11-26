import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String? selectedSize;
  final ValueChanged<String> onSizeSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (sizes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: sizes.map((size) {
            return ChoiceChip(
              label: Text(size),
              selected: selectedSize == size,
              onSelected: (_) => onSizeSelected(size),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
