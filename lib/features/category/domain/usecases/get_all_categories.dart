import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetAllCategories
    implements UseCase<PaginatedCategories, GetAllCategoriesParams> {
  final CategoryRepository categoryRepository;

  const GetAllCategories(this.categoryRepository);

  @override
  Future<Either<Failure, PaginatedCategories>> call(
    GetAllCategoriesParams params,
  ) {
    return categoryRepository.getAllCategories(
      page: params.page,
      count: params.count,
    );
  }
}

class GetAllCategoriesParams {
  final int page;
  final int count;

  const GetAllCategoriesParams({
    required this.page,
    required this.count,
  });
}
