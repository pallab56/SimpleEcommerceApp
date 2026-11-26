import '../../../../core/common/entities/category.dart';
import '../../../../core/constants/api_urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../category/data/models/category_model.dart';
import '../../domain/entities/home_data.dart';
import '../models/banner_model.dart';
import '../models/home_product_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<HomeData> getHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  const HomeRemoteDataSourceImpl(this.apiClient);

  static const int _initialPage = 1;
  static const int _categoriesLimit = 20;
  static const int _sectionProductsLimit = 4;

  static const String _popularSlug = 'popular';
  static const String _specialSlug = 'special';
  static const String _newArrivalSlug = 'new-arr';

  @override
  Future<HomeData> getHomeData() async {
    try {
      final initialResults = await Future.wait([
        _fetchBanners(),
        _fetchRawCategories(),
      ]);

      final banners = initialResults[0] as List<BannerModel>;
      final rawCategories = initialResults[1] as List<Map<String, dynamic>>;

      final categories = rawCategories
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      final popularCat = _findCategoryBySlug(rawCategories, _popularSlug);
      final specialCat = _findCategoryBySlug(rawCategories, _specialSlug);
      final newArrivalCat = _findCategoryBySlug(rawCategories, _newArrivalSlug);

      final productResults = await Future.wait([
        _fetchProductsByCategory(popularCat?.id),
        _fetchProductsByCategory(specialCat?.id),
        _fetchProductsByCategory(newArrivalCat?.id),
      ]);

      return HomeData(
        banners: banners,
        categories: categories,
        popularProducts: productResults[0],
        specialProducts: productResults[1],
        newProducts: productResults[2],
        popularCategory: popularCat,
        specialCategory: specialCat,
        newArrivalCategory: newArrivalCat,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<List<BannerModel>> _fetchBanners() async {
    final response = await apiClient.get(ApiUrls.sliders);
    if (response['status'] == 'success' && response['data'] != null) {
      final list = response['data']['results'] as List<dynamic>? ?? [];
      return list
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> _fetchRawCategories() async {
    final response = await apiClient.get(
      ApiUrls.categories,
      queryParams: {
        'page': _initialPage.toString(),
        'count': _categoriesLimit.toString(),
      },
    );
    if (response['status'] == 'success' && response['data'] != null) {
      final list = response['data']['results'] as List<dynamic>? ?? [];
      return list.cast<Map<String, dynamic>>();
    }
    throw ServerException(
      message: response['msg'] ?? 'Failed to load home categories',
    );
  }

  Category? _findCategoryBySlug(
    List<Map<String, dynamic>> rawCategories,
    String targetSlug,
  ) {
    for (final cat in rawCategories) {
      final slug = (cat['slug'] ?? '').toString().trim().toLowerCase();
      if (slug == targetSlug) {
        return CategoryModel.fromJson(cat);
      }
    }
    return null;
  }

  Future<List<HomeProductModel>> _fetchProductsByCategory(
    String? categoryId,
  ) async {
    if (categoryId == null || categoryId.isEmpty) return [];

    final response = await apiClient.get(
      ApiUrls.products,
      queryParams: {
        'category': categoryId,
        'count': _sectionProductsLimit.toString(),
      },
    );
    if (response['status'] == 'success' && response['data'] != null) {
      final list = response['data']['results'] as List<dynamic>? ?? [];
      return list
          .map((e) => HomeProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
