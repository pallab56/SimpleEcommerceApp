import '../../../../core/common/entities/category.dart';
import '../../../../core/common/entities/product.dart';
import 'banner.dart';

class HomeData {
  final List<BannerEntity> banners;
  final List<Category> categories;
  final List<Product> popularProducts;
  final List<Product> specialProducts;
  final List<Product> newProducts;
  final Category? popularCategory;
  final Category? specialCategory;
  final Category? newArrivalCategory;

  const HomeData({
    required this.banners,
    required this.categories,
    required this.popularProducts,
    required this.specialProducts,
    required this.newProducts,
    this.popularCategory,
    this.specialCategory,
    this.newArrivalCategory,
  });
}
