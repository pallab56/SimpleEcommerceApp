import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/wishlist_item.dart';
import '../../domain/usecases/add_to_wishlist.dart';
import '../../domain/usecases/get_wishlist.dart';
import '../../domain/usecases/remove_from_wishlist.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlist _getWishlist;
  final AddToWishlist _addToWishlist;
  final RemoveFromWishlist _removeFromWishlist;

  WishlistCubit({
    required GetWishlist getWishlist,
    required AddToWishlist addToWishlist,
    required RemoveFromWishlist removeFromWishlist,
  })  : _getWishlist = getWishlist,
        _addToWishlist = addToWishlist,
        _removeFromWishlist = removeFromWishlist,
        super(const WishlistState());

  Future<void> loadWishlist() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getWishlist(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.message),
      ),
      (items) => emit(
        state.copyWith(items: items, isLoading: false, errorMessage: null),
      ),
    );
  }

  Future<void> toggleWishlist(Product product) async {
    final existing = state.findByProductId(product.id);
    final previousItems = List<WishlistItem>.from(state.items);

    if (existing != null) {
      emit(
        state.copyWith(
          items: state.items
              .where((item) => item.product.id != product.id)
              .toList(),
          errorMessage: null,
        ),
      );

      final deleteId = existing.id.isNotEmpty ? existing.id : product.id;
      final result = await _removeFromWishlist(deleteId);
      result.fold(
        (failure) => emit(
          state.copyWith(items: previousItems, errorMessage: failure.message),
        ),
        (_) {},
      );
    } else {
      emit(
        state.copyWith(
          items: [
            ...state.items,
            WishlistItem(id: '', product: product),
          ],
          errorMessage: null,
        ),
      );

      final result = await _addToWishlist(product.id);
      await result.fold(
        (failure) async => emit(
          state.copyWith(items: previousItems, errorMessage: failure.message),
        ),
        (_) async {
          final refreshed = await _getWishlist(const NoParams());
          refreshed.fold(
            (_) {},
            (items) => emit(state.copyWith(items: items)),
          );
        },
      );
    }
  }
}
