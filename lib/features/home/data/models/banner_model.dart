// BannerModel — JSON DTO for promo banner.
import '../../domain/entities/banner.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    super.productId,
    super.categoryId,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? json['description'] ?? '',
      imageUrl: json['photo_url'] ?? json['image'] ?? json['icon'] ?? '',
      productId: json['product'] is Map ? json['product']['_id'] : json['product'],
      categoryId: json['category'] is Map ? json['category']['_id'] : json['category'],
    );
  }
}
