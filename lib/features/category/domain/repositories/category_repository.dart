import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/error/failures.dart';
import '../entities/category.dart';

abstract interface class CategoryRepository {
  Future<Either<Failure, PaginatedCategories>> getAllCategories({
    required int page,
    required int count,
  });

  Future<Either<Failure, List<Product>>> getCategoryProducts({
    required String categoryId,
    required int page,
    required int count,
  });
}
