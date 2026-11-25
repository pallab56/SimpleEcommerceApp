import 'package:equatable/equatable.dart';

/// Shared Product entity — used in Home, Cart, and Wishlist features.
class Product extends Equatable {
  final String id;
  final String title;
  final double price;
  final double rating;
  final String imageUrl;
  final String categoryId;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [id, title, price, rating, imageUrl, categoryId];
}
