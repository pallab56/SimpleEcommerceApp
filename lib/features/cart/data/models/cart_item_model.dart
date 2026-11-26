// CartItemModel — JSON DTO.
import '../../../home/data/models/home_product_model.dart';
import '../../domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.product,
    required super.quantity,
    super.color,
    super.size,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final productMap = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : json;

    return CartItemModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      product: HomeProductModel.fromJson(productMap),
      quantity: (json['quantity'] ?? json['qty'] ?? 1) as int,
      color: json['color']?.toString(),
      size: json['size']?.toString(),
    );
  }
}
