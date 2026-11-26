import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String productId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime? createdAt;

  const Review({
    required this.id,
    required this.productId,
    required this.userName,
    required this.comment,
    required this.rating,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        productId,
        userName,
        comment,
        rating,
        createdAt,
      ];
}
