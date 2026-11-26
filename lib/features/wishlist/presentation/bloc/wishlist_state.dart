import 'package:equatable/equatable.dart';
import '../../domain/entities/wishlist_item.dart';

class WishlistState extends Equatable {
  final List<WishlistItem> items;
  final bool isLoading;
  final String? errorMessage;

  const WishlistState({
    this.items = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  bool isWishlisted(String productId) =>
      items.any((item) => item.product.id == productId);

  WishlistItem? findByProductId(String productId) {
    for (final item in items) {
      if (item.product.id == productId) return item;
    }
    return null;
  }

  WishlistState copyWith({
    List<WishlistItem>? items,
    bool? isLoading,
    String? errorMessage,
  }) {
    return WishlistState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, errorMessage];
}
