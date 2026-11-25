import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/category.dart';
import 'category_state.dart';

/// CategoryCubit — loads the full list of categories.
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryInitial());

  Future<void> loadCategories() async {
    emit(const CategoryLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 400));

      // Mock — replace with repository call
      final categories = [
        const Category(id: '1', name: 'Mobiles', iconUrl: 'https://cdn-icons-png.flaticon.com/512/0/191.png'),
        const Category(id: '2', name: 'Food', iconUrl: 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'),
        const Category(id: '3', name: 'Fashion', iconUrl: 'https://cdn-icons-png.flaticon.com/512/3281/3281289.png'),
        const Category(id: '4', name: 'Furniture', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2271/2271069.png'),
        const Category(id: '5', name: 'Electronics', iconUrl: 'https://cdn-icons-png.flaticon.com/512/3659/3659899.png'),
        const Category(id: '6', name: 'Book', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2436/2436874.png'),
        const Category(id: '7', name: 'Sports', iconUrl: 'https://cdn-icons-png.flaticon.com/512/857/857435.png'),
        const Category(id: '8', name: 'Health', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2965/2965567.png'),
        const Category(id: '9', name: 'Beauty', iconUrl: 'https://cdn-icons-png.flaticon.com/512/3081/3081559.png'),
        const Category(id: '10', name: 'Toys', iconUrl: 'https://cdn-icons-png.flaticon.com/512/3082/3082048.png'),
        const Category(id: '11', name: 'Grocery', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2553/2553652.png'),
        const Category(id: '12', name: 'Travel', iconUrl: 'https://cdn-icons-png.flaticon.com/512/201/201623.png'),
      ];

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
