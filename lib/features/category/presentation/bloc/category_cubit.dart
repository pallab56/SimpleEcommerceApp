import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_categories.dart';
import '../constants/category_constants.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetAllCategories _getAllCategories;

  CategoryCubit({
    required GetAllCategories getAllCategories,
  })  : _getAllCategories = getAllCategories,
        super(const CategoryInitial());

  Future<void> loadCategoriesIfNeeded() async {
    if (state is CategoryInitial || state is CategoryError) {
      await loadCategories();
    }
  }

  Future<void> loadCategories() async {
    emit(const CategoryLoading());

    final result = await _getAllCategories(
      const GetAllCategoriesParams(
        page: CategoryConstants.defaultPage,
        count: CategoryConstants.defaultCategoriesPageSize,
      ),
    );

    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (paginated) => emit(
        CategoryLoaded(
          categories: paginated.categories,
          nextPage: paginated.nextPage,
        ),
      ),
    );
  }

  Future<void> loadMoreCategories() async {
    final current = state;
    if (current is! CategoryLoaded ||
        !current.hasMore ||
        current.isLoadingMore) {
      return;
    }

    emit(
      CategoryLoaded(
        categories: current.categories,
        nextPage: current.nextPage,
        isLoadingMore: true,
      ),
    );

    final result = await _getAllCategories(
      GetAllCategoriesParams(
        page: current.nextPage!,
        count: CategoryConstants.defaultCategoriesPageSize,
      ),
    );

    result.fold(
      (_) => emit(
        CategoryLoaded(
          categories: current.categories,
          nextPage: current.nextPage,
          isLoadingMore: false,
        ),
      ),
      (paginated) => emit(
        CategoryLoaded(
          categories: [...current.categories, ...paginated.categories],
          nextPage: paginated.nextPage,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
