import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/product.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;
  final String? color;
  final String? size;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.color,
    this.size,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? color,
    String? size,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity, color, size];
}
