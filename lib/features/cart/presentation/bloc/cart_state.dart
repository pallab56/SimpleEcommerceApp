import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final String? actionMessage;

  const CartState({
    this.items = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.actionMessage,
  });

  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    List<CartItem>? items,
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    String? actionMessage,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      actionMessage: actionMessage,
    );
  }

  @override
  List<Object?> get props => [
        items,
        isLoading,
        isSubmitting,
        errorMessage,
        actionMessage,
      ];
}
