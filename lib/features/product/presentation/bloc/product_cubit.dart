import 'package:ecommerceapp/features/product/domain/entities/review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/constants/app_assets.dart';

import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductInitial());

  Future<void> loadProduct(String productId) async {
    emit(const ProductLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 400));

      final product = Product(
        id: productId,
        title: 'Happy New Year Special Shoe',
        price: 100.00,
        rating: 4.5,
        imageUrl: AppAssets.shoe,
        categoryId: '1',
      );

      final reviews = List.generate(
        5,
        (i) => Review(
          id: 'r$i',
          authorName: ['Alice Smith', 'Bob Lee', 'Cara Jones', 'Dan White', 'Eva Brown'][i],
          avatarUrl: 'https://i.pravatar.cc/80?img=${i + 1}',
          rating: [5.0, 4.0, 4.5, 3.0, 5.0][i],
          comment: 'Great product! Very comfortable and stylish. Highly recommend.',
          date: '2024-0${i + 1}-15',
        ),
      );

      emit(ProductLoaded(
        product: product,
        reviews: reviews,
        selectedSize: 'M',
        quantity: 1,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void selectSize(String size) {
    final s = state;
    if (s is ProductLoaded) emit(s.copyWith(selectedSize: size));
  }

  void increment() {
    final s = state;
    if (s is ProductLoaded) emit(s.copyWith(quantity: s.quantity + 1));
  }

  void decrement() {
    final s = state;
    if (s is ProductLoaded && s.quantity > 1) {
      emit(s.copyWith(quantity: s.quantity - 1));
    }
  }
}
