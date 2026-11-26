import '../../../../core/constants/api_urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../home/data/models/home_product_model.dart';
import '../models/paginated_categories_model.dart';

abstract interface class CategoryRemoteDataSource {
  Future<PaginatedCategoriesModel> getAllCategories({
    required int page,
    required int count,
  });

  Future<List<HomeProductModel>> getCategoryProducts({
    required String categoryId,
    required int page,
    required int count,
  });
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient apiClient;

  const CategoryRemoteDataSourceImpl(this.apiClient);

  @override
  Future<PaginatedCategoriesModel> getAllCategories({
    required int page,
    required int count,
  }) async {
    try {
      final response = await apiClient.get(
        ApiUrls.categories,
        queryParams: {
          'page': page.toString(),
          'count': count.toString(),
        },
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return PaginatedCategoriesModel.fromJson(
          response['data'] as Map<String, dynamic>,
        );
      }
      throw ServerException(
        message: response['msg'] ?? 'Failed to retrieve categories',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<HomeProductModel>> getCategoryProducts({
    required String categoryId,
    required int page,
    required int count,
  }) async {
    try {
      final response = await apiClient.get(
        ApiUrls.products,
        queryParams: {
          'category': categoryId,
          'page': page.toString(),
          'count': count.toString(),
        },
      );

      if (response['status'] == 'success' && response['data'] != null) {
        final results = response['data']['results'] as List<dynamic>? ?? [];
        return results
            .map((e) => HomeProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      throw ServerException(
        message: response['msg'] ?? 'Failed to load category products',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
