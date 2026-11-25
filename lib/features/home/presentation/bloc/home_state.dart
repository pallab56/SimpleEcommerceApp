import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/product.dart';
import '../../../../core/common/entities/category.dart';

/// States for [HomeCubit].
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Product> popularProducts;
  final List<Product> specialProducts;
  final List<Product> newProducts;

  const HomeLoaded({
    required this.categories,
    required this.popularProducts,
    required this.specialProducts,
    required this.newProducts,
  });

  @override
  List<Object?> get props =>
      [categories, popularProducts, specialProducts, newProducts];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
