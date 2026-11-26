// WishlistItem entity — wraps a Product.
import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/product.dart';

class WishlistItem extends Equatable {
  final String id; // Wishlist document _id (used for DELETE)
  final Product product;

  const WishlistItem({
    required this.id,
    required this.product,
  });

  @override
  List<Object?> get props => [id, product];
}
