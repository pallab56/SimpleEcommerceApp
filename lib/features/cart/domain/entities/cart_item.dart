import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/product.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  const CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
  });

  CartItem copyWith({int? quantity}) => CartItem(
        product: product,
        quantity: quantity ?? this.quantity,
        selectedSize: selectedSize,
        selectedColor: selectedColor,
      );

  double get subtotal => product.price * quantity;

  @override
  List<Object?> get props => [product.id, quantity, selectedSize, selectedColor];
}
