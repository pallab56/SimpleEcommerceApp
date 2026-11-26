// GetCategoryProducts use case — returns products filtered by category.
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/category_repository.dart';

class GetCategoryProducts
    implements UseCase<List<Product>, GetCategoryProductsParams> {
  final CategoryRepository categoryRepository;

  const GetCategoryProducts(this.categoryRepository);

  @override
  Future<Either<Failure, List<Product>>> call(
    GetCategoryProductsParams params,
  ) {
    return categoryRepository.getCategoryProducts(
      categoryId: params.categoryId,
      page: params.page,
      count: params.count,
    );
  }
}

class GetCategoryProductsParams {
  final String categoryId;
  final int page;
  final int count;

  const GetCategoryProductsParams({
    required this.categoryId,
    required this.page,
    required this.count,
  });
}
