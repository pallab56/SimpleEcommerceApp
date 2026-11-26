import '../../../../core/constants/api_urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(String productId);
  Future<List<ReviewModel>> getProductReviews(String productId);
  Future<ReviewModel> createReview({
    required String productId,
    required String comment,
    required double rating,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  const ProductRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProductDetailsModel> getProductDetails(String productId) async {
    try {
      final response = await apiClient.get(ApiUrls.productDetails(productId));

      if (response['status'] == 'success' && response['data'] != null) {
        final data = response['data'];
        if (data is Map<String, dynamic>) {
          if (data['results'] is List && (data['results'] as List).isNotEmpty) {
            return ProductDetailsModel.fromJson(
              (data['results'] as List).first as Map<String, dynamic>,
            );
          }
          return ProductDetailsModel.fromJson(data);
        } else if (data is List && data.isNotEmpty) {
          return ProductDetailsModel.fromJson(
            data.first as Map<String, dynamic>,
          );
        }
      }
      throw ServerException(
        message: response['msg'] ?? 'Failed to load product details',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<ReviewModel>> getProductReviews(String productId) async {
    try {
      final response = await apiClient.get(
        ApiUrls.reviews,
        queryParams: {'product': productId},
      );

      if (response['status'] == 'success' && response['data'] != null) {
        final data = response['data'];
        final results = data is Map<String, dynamic>
            ? (data['results'] as List<dynamic>? ?? [])
            : (data as List<dynamic>? ?? []);
        return results
            .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ServerException(
        message: response['msg'] ?? 'Failed to load reviews',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ReviewModel> createReview({
    required String productId,
    required String comment,
    required double rating,
  }) async {
    try {
      final response = await apiClient.post(
        ApiUrls.reviews,
        body: {
          'product': productId,
          'comment': comment,
          'rating': rating,
        },
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return ReviewModel.fromJson(
          response['data'] as Map<String, dynamic>,
        );
      }
      throw ServerException(
        message: response['msg'] ?? 'Failed to submit review',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
