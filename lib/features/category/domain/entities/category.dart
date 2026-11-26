import '../../../../core/common/entities/category.dart';

export '../../../../core/common/entities/category.dart';

class PaginatedCategories {
  final List<Category> categories;
  final int? nextPage;
  final int lastPage;

  const PaginatedCategories({
    required this.categories,
    this.nextPage,
    required this.lastPage,
  });

  bool get hasMore => nextPage != null;
}
