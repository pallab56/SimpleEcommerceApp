import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_category_products.dart';
import '../constants/category_constants.dart';
import 'category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  final GetCategoryProducts _getCategoryProducts;

  CategoryProductsCubit({
    required GetCategoryProducts getCategoryProducts,
  })  : _getCategoryProducts = getCategoryProducts,
        super(const CategoryProductsInitial());

  Future<void> loadProducts(String categoryId) async {
    emit(const CategoryProductsLoading());

    final result = await _getCategoryProducts(
      GetCategoryProductsParams(
        categoryId: categoryId,
        page: CategoryConstants.defaultPage,
        count: CategoryConstants.defaultProductsPageSize,
      ),
    );

    result.fold(
      (failure) => emit(CategoryProductsError(failure.message)),
      (products) => emit(CategoryProductsLoaded(products)),
    );
  }
}
