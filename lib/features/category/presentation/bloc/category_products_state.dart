import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/product.dart';

sealed class CategoryProductsState extends Equatable {
  const CategoryProductsState();

  @override
  List<Object?> get props => [];
}

final class CategoryProductsInitial extends CategoryProductsState {
  const CategoryProductsInitial();
}

final class CategoryProductsLoading extends CategoryProductsState {
  const CategoryProductsLoading();
}

final class CategoryProductsLoaded extends CategoryProductsState {
  final List<Product> products;

  const CategoryProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

final class CategoryProductsError extends CategoryProductsState {
  final String message;

  const CategoryProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
