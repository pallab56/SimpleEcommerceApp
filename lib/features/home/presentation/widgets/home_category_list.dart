import 'package:flutter/material.dart';
import '../../../../core/common/entities/category.dart';
import '../../../../core/common/widgets/category_card.dart';

/// Horizontal scrolling row of CategoryCards shown on the Home screen.
class HomeCategoryList extends StatelessWidget {
  final List<Category> categories;
  final ValueChanged<Category> onCategoryTap;

  const HomeCategoryList({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: categories.length,
        separatorBuilder: (ctx, i) => const SizedBox(width: 12),
        itemBuilder: (_, i) => CategoryCard(
          category: categories[i],
          onTap: () => onCategoryTap(categories[i]),
        ),
      ),
    );
  }
}
