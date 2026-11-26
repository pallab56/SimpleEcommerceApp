import 'package:equatable/equatable.dart';
import '../../domain/entities/category.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

final class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

final class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

final class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final int? nextPage;
  final bool isLoadingMore;

  const CategoryLoaded({
    required this.categories,
    this.nextPage,
    this.isLoadingMore = false,
  });

  bool get hasMore => nextPage != null;

  @override
  List<Object?> get props => [categories, nextPage, isLoadingMore];
}

final class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
