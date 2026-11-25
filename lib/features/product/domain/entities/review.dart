import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String authorName;
  final String avatarUrl;
  final double rating;
  final String comment;
  final String date;

  const Review({
    required this.id,
    required this.authorName,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  List<Object?> get props => [id, authorName, rating, comment];
}
