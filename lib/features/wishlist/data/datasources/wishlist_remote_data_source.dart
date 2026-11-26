// WishlistRemoteDataSource — fetch, add, remove wishlist items.
import '../../../../core/constants/api_urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/wishlist_item_model.dart';

abstract interface class WishlistRemoteDataSource {
  Future<List<WishlistItemModel>> getWishlist();
  Future<void> addToWishlist(String productId);
  Future<void> removeFromWishlist(String wishlistItemId);
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final ApiClient apiClient;

  const WishlistRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<WishlistItemModel>> getWishlist() async {
    try {
      final response = await apiClient.get(ApiUrls.wishlist);
      if (response['status'] == 'success' && response['data'] != null) {
        final results = response['data']['results'] as List<dynamic>? ?? [];
        return results
            .map((e) => WishlistItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ServerException(
        message: response['msg'] ?? 'Failed to load wishlist',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> addToWishlist(String productId) async {
    try {
      final response = await apiClient.post(
        ApiUrls.wishlist,
        body: {'product': productId},
      );
      if (response['status'] != 'success') {
        throw ServerException(
          message: response['msg'] ?? 'Failed to add to wishlist',
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> removeFromWishlist(String wishlistItemId) async {
    try {
      final response = await apiClient.delete(
        ApiUrls.removeWishlist(wishlistItemId),
      );
      if (response['status'] != 'success') {
        throw ServerException(
          message: response['msg'] ?? 'Failed to remove from wishlist',
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
