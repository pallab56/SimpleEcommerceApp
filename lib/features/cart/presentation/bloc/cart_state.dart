import 'package:equatable/equatable.dart';
import '../../../cart/domain/entities/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  const CartLoaded(this.items);

  double get total => items.fold(0, (sum, i) => sum + i.subtotal);

  @override
  List<Object?> get props => [items];
}
