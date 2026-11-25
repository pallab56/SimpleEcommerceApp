import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/common/entities/category.dart';
import '../../../../core/constants/app_assets.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  Future<void> loadHome() async {
    emit(const HomeLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 400));

      final categories = [
        const Category(id: '1', name: 'Mobiles', iconUrl: 'https://cdn-icons-png.flaticon.com/512/0/191.png'),
        const Category(id: '2', name: 'Food', iconUrl: 'https://cdn-icons-png.flaticon.com/512/1046/1046784.png'),
        const Category(id: '3', name: 'Fashion', iconUrl: 'https://cdn-icons-png.flaticon.com/512/3281/3281289.png'),
        const Category(id: '4', name: 'Furniture', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2271/2271069.png'),
        const Category(id: '5', name: 'Electronics', iconUrl: 'https://cdn-icons-png.flaticon.com/512/3659/3659899.png'),
        const Category(id: '6', name: 'Book', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2436/2436874.png'),
      ];

      final products = List.generate(
        6,
        (i) => Product(
          id: 'p$i',
          title: 'Happy New Year Special Shoe',
          price: 100.0 + i * 10,
          rating: 4.0 + (i % 5) * 0.2,
          imageUrl: AppAssets.shoe,          // ← local asset
          categoryId: categories[i % categories.length].id,
        ),
      );

      emit(HomeLoaded(
        categories: categories,
        popularProducts: products,
        specialProducts: products.reversed.toList(),
        newProducts: products.sublist(0, 3),
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
