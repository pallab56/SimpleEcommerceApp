import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_product_details.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductDetails _getProductDetails;

  ProductCubit({
    required GetProductDetails getProductDetails,
  })  : _getProductDetails = getProductDetails,
        super(const ProductInitial());

  Future<void> loadProductDetails(String productId) async {
    if (productId.isEmpty) {
      emit(const ProductError('Invalid product ID'));
      return;
    }

    emit(const ProductLoading());

    final result = await _getProductDetails(productId);

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(
        ProductLoaded(
          product: product,
          selectedColor:
              product.colors.isNotEmpty ? product.colors.first : null,
          selectedSize: product.sizes.isNotEmpty ? product.sizes.first : null,
        ),
      ),
    );
  }

  void incrementQuantity() {
    final current = state;
    if (current is ProductLoaded) {
      emit(current.copyWith(quantity: current.quantity + 1));
    }
  }

  void decrementQuantity() {
    final current = state;
    if (current is ProductLoaded && current.quantity > 1) {
      emit(current.copyWith(quantity: current.quantity - 1));
    }
  }

  void selectColor(String color) {
    final current = state;
    if (current is ProductLoaded) {
      emit(current.copyWith(selectedColor: color));
    }
  }

  void selectSize(String size) {
    final current = state;
    if (current is ProductLoaded) {
      emit(current.copyWith(selectedSize: size));
    }
  }
}
