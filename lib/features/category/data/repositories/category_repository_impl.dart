import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  const CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedCategories>> getAllCategories({
    required int page,
    required int count,
  }) async {
    try {
      final result = await remoteDataSource.getAllCategories(
        page: page,
        count: count,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCategoryProducts({
    required String categoryId,
    required int page,
    required int count,
  }) async {
    try {
      final products = await remoteDataSource.getCategoryProducts(
        categoryId: categoryId,
        page: page,
        count: count,
      );
      return right(products);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
