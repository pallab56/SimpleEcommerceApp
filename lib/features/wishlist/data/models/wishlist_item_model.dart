// WishlistItemModel — JSON DTO.
import '../../../home/data/models/home_product_model.dart';
import '../../domain/entities/wishlist_item.dart';

class WishlistItemModel extends WishlistItem {
  const WishlistItemModel({
    required super.id,
    required super.product,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    final productMap = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : json;

    return WishlistItemModel(
      id: json['_id']?.toString() ?? '',
      product: HomeProductModel.fromJson(productMap),
    );
  }
}
