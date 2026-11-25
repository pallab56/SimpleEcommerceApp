import 'package:ecommerceapp/features/product/domain/entities/review.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/product.dart';


abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final Product product;
  final List<Review> reviews;
  final String selectedSize;
  final int quantity;

  const ProductLoaded({
    required this.product,
    required this.reviews,
    required this.selectedSize,
    required this.quantity,
  });

  ProductLoaded copyWith({
    String? selectedSize,
    int? quantity,
  }) =>
      ProductLoaded(
        product: product,
        reviews: reviews,
        selectedSize: selectedSize ?? this.selectedSize,
        quantity: quantity ?? this.quantity,
      );

  @override
  List<Object?> get props => [product, reviews, selectedSize, quantity];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override
  List<Object?> get props => [message];
}
