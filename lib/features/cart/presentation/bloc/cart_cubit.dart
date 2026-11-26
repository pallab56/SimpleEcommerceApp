import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_cart_quantity.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItems _getCartItems;
  final AddToCart _addToCart;
  final UpdateCartQuantity _updateCartQuantity;
  final RemoveFromCart _removeFromCart;

  CartCubit({
    required GetCartItems getCartItems,
    required AddToCart addToCart,
    required UpdateCartQuantity updateCartQuantity,
    required RemoveFromCart removeFromCart,
  })  : _getCartItems = getCartItems,
        _addToCart = addToCart,
        _updateCartQuantity = updateCartQuantity,
        _removeFromCart = removeFromCart,
        super(const CartState());

  Future<void> loadCart() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getCartItems(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.message),
      ),
      (items) => emit(
        state.copyWith(items: items, isLoading: false, errorMessage: null),
      ),
    );
  }

  Future<void> addItem({
    required String productId,
    int quantity = 1,
    String? color,
    String? size,
  }) async {
    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await _addToCart(
      AddToCartParams(
        productId: productId,
        quantity: quantity,
        color: color,
        size: size,
      ),
    );

    await result.fold(
      (failure) async => emit(
        state.copyWith(isSubmitting: false, errorMessage: failure.message),
      ),
      (_) async {
        final refreshed = await _getCartItems(const NoParams());
        refreshed.fold(
          (_) => emit(
            state.copyWith(
              isSubmitting: false,
              actionMessage: 'Added to cart',
            ),
          ),
          (items) => emit(
            state.copyWith(
              items: items,
              isSubmitting: false,
              actionMessage: 'Added to cart',
            ),
          ),
        );
      },
    );
  }

  Future<void> updateQuantity({
    required String cartItemId,
    required int newQuantity,
  }) async {
    if (newQuantity < 1) return;

    final previousItems = List<CartItem>.from(state.items);
    final updatedItems = state.items.map((item) {
      return item.id == cartItemId ? item.copyWith(quantity: newQuantity) : item;
    }).toList();

    emit(state.copyWith(items: updatedItems, errorMessage: null));

    final result = await _updateCartQuantity(
      UpdateCartQuantityParams(
        cartItemId: cartItemId,
        quantity: newQuantity,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(items: previousItems, errorMessage: failure.message),
      ),
      (_) {},
    );
  }

  Future<void> removeItem(String cartItemId) async {
    final previousItems = List<CartItem>.from(state.items);
    final updatedItems =
        state.items.where((item) => item.id != cartItemId).toList();

    emit(state.copyWith(items: updatedItems, errorMessage: null));

    final result = await _removeFromCart(cartItemId);
    result.fold(
      (failure) => emit(
        state.copyWith(items: previousItems, errorMessage: failure.message),
      ),
      (_) => emit(state.copyWith(actionMessage: 'Item removed from cart')),
    );
  }
}
