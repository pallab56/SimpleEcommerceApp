// CartRemoteDataSource — add, remove, update cart items.
import '../../../../core/constants/api_urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/cart_item_model.dart';

abstract interface class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItems();

  Future<void> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  });

  Future<void> updateCartQuantity({
    required String cartItemId,
    required int quantity,
  });

  Future<void> removeFromCart(String cartItemId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient apiClient;

  const CartRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CartItemModel>> getCartItems() async {
    try {
      final response = await apiClient.get(ApiUrls.cart);
      if (response['status'] == 'success' && response['data'] != null) {
        final data = response['data'];
        final results = data is Map<String, dynamic>
            ? (data['results'] as List<dynamic>? ?? [])
            : (data as List<dynamic>? ?? []);
        return results
            .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ServerException(
        message: response['msg'] ?? 'Failed to load cart items',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  }) async {
    try {
      final response = await apiClient.post(
        ApiUrls.cart,
        body: {
          'product': productId,
          'quantity': quantity,
          if (color != null && color.isNotEmpty) 'color': color,
          if (size != null && size.isNotEmpty) 'size': size,
        },
      );
      if (response['status'] != 'success') {
        throw ServerException(
          message: response['msg'] ?? 'Failed to add item to cart',
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateCartQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await apiClient.patch(
        ApiUrls.cartItem(cartItemId),
        body: {'quantity': quantity},
      );
      if (response['status'] != 'success') {
        throw ServerException(
          message: response['msg'] ?? 'Failed to update cart quantity',
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> removeFromCart(String cartItemId) async {
    try {
      final response = await apiClient.delete(ApiUrls.cartItem(cartItemId));
      if (response['status'] != 'success') {
        throw ServerException(
          message: response['msg'] ?? 'Failed to remove item from cart',
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
