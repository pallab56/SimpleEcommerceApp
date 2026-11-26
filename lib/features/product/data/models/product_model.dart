// ProductModel — JSON DTO.
import '../../domain/entities/product_details.dart';

class ProductDetailsModel extends ProductDetails {
  const ProductDetailsModel({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.imageUrl,
    required super.categoryId,
    required super.description,
    required super.photos,
    required super.colors,
    required super.sizes,
    required super.availableQuantity,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final rawPhotos = (json['photos'] as List<dynamic>? ??
            json['images'] as List<dynamic>? ??
            [])
        .map((e) => e.toString())
        .where((url) => url.isNotEmpty)
        .toList();

    final singleImage =
        (json['image'] ?? json['photo_url'] ?? '').toString();
    final photos = rawPhotos.isNotEmpty
        ? rawPhotos
        : (singleImage.isNotEmpty ? [singleImage] : <String>[]);

    final colors = (json['colors'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();
    final sizes = (json['sizes'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList();

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

    return ProductDetailsModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      price: (json['current_price'] ?? json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 4.5).toDouble(),
      imageUrl: photos.isNotEmpty ? photos.first : '',
      categoryId: extractedCategoryId,
      description: json['description']?.toString() ?? '',
      photos: photos,
      colors: colors,
      sizes: sizes,
      availableQuantity: (json['quantity'] ?? 1) as int,
    );
  }
}
