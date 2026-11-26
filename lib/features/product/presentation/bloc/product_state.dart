import 'package:equatable/equatable.dart';
import '../../domain/entities/product_details.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductLoading extends ProductState {
  const ProductLoading();
}

final class ProductLoaded extends ProductState {
  final ProductDetails product;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;

  const ProductLoaded({
    required this.product,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
  });

  ProductLoaded copyWith({
    int? quantity,
    String? selectedColor,
    String? selectedSize,
  }) {
    return ProductLoaded(
      product: product,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
    );
  }

  @override
  List<Object?> get props => [product, quantity, selectedColor, selectedSize];
}

final class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
