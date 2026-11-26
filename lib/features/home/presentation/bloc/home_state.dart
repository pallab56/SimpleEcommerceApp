import 'package:equatable/equatable.dart';
import '../../../../core/common/entities/category.dart';
import '../../../../core/common/entities/product.dart';
import '../../domain/entities/banner.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final List<BannerEntity> banners;
  final List<Category> categories;
  final List<Product> popularProducts;
  final List<Product> specialProducts;
  final List<Product> newProducts;
  final Category? popularCategory;
  final Category? specialCategory;
  final Category? newArrivalCategory;

  const HomeLoaded({
    required this.banners,
    required this.categories,
    required this.popularProducts,
    required this.specialProducts,
    required this.newProducts,
    this.popularCategory,
    this.specialCategory,
    this.newArrivalCategory,
  });

  @override
  List<Object?> get props => [
        banners,
        categories,
        popularProducts,
        specialProducts,
        newProducts,
        popularCategory,
        specialCategory,
        newArrivalCategory,
      ];
}

final class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
