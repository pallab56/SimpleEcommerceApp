import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/product.dart';
import 'wishlist_state.dart';

/// WishlistCubit — manages loading and toggling wishlist items.
class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistInitial());

  final List<Product> _items = [];

  Future<void> loadWishlist() async {
    emit(const WishlistLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      // Mock — replace with repository call
      emit(WishlistLoaded(List.from(_items)));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
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
