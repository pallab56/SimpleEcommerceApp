import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/product.dart';

abstract class CategoryProductsState extends Equatable {
  const CategoryProductsState();
  @override
  List<Object?> get props => [];
}

class CategoryProductsInitial extends CategoryProductsState {
  const CategoryProductsInitial();
}

class CategoryProductsLoading extends CategoryProductsState {
  const CategoryProductsLoading();
}

class CategoryProductsLoaded extends CategoryProductsState {
  final List<Product> products;
  const CategoryProductsLoaded(this.products);
  @override
  List<Object?> get props => [products];
}

class CategoryProductsError extends CategoryProductsState {
  final String message;
  const CategoryProductsError(this.message);
  @override
  List<Object?> get props => [message];
}
