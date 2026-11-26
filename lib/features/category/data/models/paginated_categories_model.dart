import '../../domain/entities/category.dart';
import 'category_model.dart';

class PaginatedCategoriesModel extends PaginatedCategories {
  const PaginatedCategoriesModel({
    required super.categories,
    super.nextPage,
    required super.lastPage,
  });

  factory PaginatedCategoriesModel.fromJson(Map<String, dynamic> data) {
    final results = data['results'] as List<dynamic>? ?? [];
    return PaginatedCategoriesModel(
      categories: results
          .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      nextPage: data['next'] as int?,
      lastPage: data['last_page'] as int? ?? 1,
    );
  }
}
