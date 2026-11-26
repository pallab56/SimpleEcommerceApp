import '../../../../core/common/entities/product.dart';

class HomeProductModel extends Product {
  const HomeProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.imageUrl,
    required super.rating,
    required super.categoryId,
  });

  factory HomeProductModel.fromJson(Map<String, dynamic> json) {
    final photos = json['photos'] as List<dynamic>?;
    final firstPhoto = (photos != null && photos.isNotEmpty)
        ? photos.first.toString()
        : (json['image'] ?? json['photo_url'] ?? '');

    // Extract categoryId whether API returns a Map, List, or String
    String extractedCategoryId = '';
    final rawCategory = json['category'] ?? json['categories'];
    if (rawCategory is Map<String, dynamic>) {
      extractedCategoryId = rawCategory['_id']?.toString() ?? '';
    } else if (rawCategory is List && rawCategory.isNotEmpty) {
      final first = rawCategory.first;
      extractedCategoryId = first is Map<String, dynamic>
          ? (first['_id']?.toString() ?? '')
          : first.toString();
    } else if (rawCategory != null) {
      extractedCategoryId = rawCategory.toString();
    }

    return HomeProductModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      price: (json['current_price'] ?? json['price'] ?? 0).toDouble(),
      imageUrl: firstPhoto,
      rating: (json['rating'] ?? 4.5).toDouble(),
      categoryId: extractedCategoryId,
    );
  }
}
