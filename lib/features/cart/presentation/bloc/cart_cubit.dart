import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial()) {
    _loadMock();
  }

  final List<CartItem> _items = [];

  void _loadMock() {
    // Seed a few demo items so the cart looks populated on first open
    final demo = [
      CartItem(
        product: Product(
          id: 'c1',
          title: 'Happy New Year Special Shoe',
          price: 100,
          rating: 4.5,
          imageUrl: AppAssets.shoe,
          categoryId: '1',
        ),
        quantity: 1,
        selectedSize: 'M',
      ),
      CartItem(
        product: Product(
          id: 'c2',
          title: 'Happy New Year Special Shoe',
          price: 120,
          rating: 4.3,
          imageUrl: AppAssets.shoe,
          categoryId: '1',
        ),
        quantity: 2,
        selectedSize: 'L',
      ),
      CartItem(
        product: Product(
          id: 'c3',
          title: 'Happy New Year Special Shoe',
          price: 90,
          rating: 4.0,
          imageUrl: AppAssets.shoe,
          categoryId: '1',
        ),
        quantity: 1,
        selectedSize: 'S',
      ),
    ];
    _items.addAll(demo);
    emit(CartLoaded(List.from(_items)));
  }

  void addToCart(Product product, {String? size, String? color}) {
    final idx = _items.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      _items[idx] = _items[idx].copyWith(quantity: _items[idx].quantity + 1);
    } else {
      _items.add(CartItem(
        product: product,
        selectedSize: size,
        selectedColor: color,
      ));
    }
    emit(CartLoaded(List.from(_items)));
  }

  void increment(String productId) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx >= 0) {
      _items[idx] = _items[idx].copyWith(quantity: _items[idx].quantity + 1);
      emit(CartLoaded(List.from(_items)));
    }
  }

  void decrement(String productId) {
    final idx = _items.indexWhere((i) => i.product.id == productId);
    if (idx >= 0 && _items[idx].quantity > 1) {
      _items[idx] = _items[idx].copyWith(quantity: _items[idx].quantity - 1);
      emit(CartLoaded(List.from(_items)));
    }
  }

  void remove(String productId) {
    _items.removeWhere((i) => i.product.id == productId);
    emit(CartLoaded(List.from(_items)));
  }
}
