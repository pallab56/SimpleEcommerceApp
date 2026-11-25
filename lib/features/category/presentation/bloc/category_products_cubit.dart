import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/product.dart';
import 'category_products_state.dart';

/// Loads products for a specific category.
class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  CategoryProductsCubit() : super(const CategoryProductsInitial());

  Future<void> loadProducts(String categoryId) async {
    emit(const CategoryProductsLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 400));

      // Mock — replace with repository call filtered by categoryId
      final products = List.generate(
        9,
        (i) => Product(
          id: 'cp$categoryId$i',
          title: 'Happy New Year Special Shoe',
          price: 100.0 + i * 15,
          rating: 4.0 + (i % 5) * 0.2,
          imageUrl:
              'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
          categoryId: categoryId,
        ),
      );

      emit(CategoryProductsLoaded(products));
    } catch (e) {
      emit(CategoryProductsError(e.toString()));
    }
  }
}
