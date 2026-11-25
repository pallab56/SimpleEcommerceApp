import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/constants/app_assets.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistInitial());

  final List<Product> _items = [];

  Future<void> loadWishlist() async {
    emit(const WishlistLoading());
    await Future.delayed(const Duration(milliseconds: 300));

    // Seed mock data so the wishlist looks populated
    if (_items.isEmpty) {
      _items.addAll(List.generate(
        6,
        (i) => Product(
          id: 'w$i',
          title: 'Happy New Year Special Shoe',
          price: 100.0 + i * 15,
          rating: 4.0 + (i % 5) * 0.2,
          imageUrl: AppAssets.shoe,
          categoryId: '1',
        ),
      ));
    }
    emit(WishlistLoaded(List.from(_items)));
  }

  void addToWishlist(Product product) {
    if (!_items.any((p) => p.id == product.id)) {
      _items.add(product);
      emit(WishlistLoaded(List.from(_items)));
    }
  }

  void removeFromWishlist(String productId) {
    _items.removeWhere((p) => p.id == productId);
    emit(WishlistLoaded(List.from(_items)));
  }

  bool isWishlisted(String productId) =>
      _items.any((p) => p.id == productId);
}
