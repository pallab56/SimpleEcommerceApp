// ReviewModel — JSON DTO for a product review.
import '../../domain/entities/review.dart';

class ReviewModel extends Review {
  const ReviewModel({
    required super.id,
    required super.productId,
    required super.userName,
    required super.comment,
    required super.rating,
    super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    String extractedName = 'Anonymous';
    final rawUser = json['user'];
    if (rawUser is Map<String, dynamic>) {
      final first = (rawUser['first_name'] ?? '').toString().trim();
      final last = (rawUser['last_name'] ?? '').toString().trim();
      final fullName = '$first $last'.trim();
      if (fullName.isNotEmpty) {
        extractedName = fullName;
      } else if (rawUser['email'] != null) {
        extractedName = rawUser['email'].toString();
      }
    } else if (json['user_name'] != null) {
      extractedName = json['user_name'].toString();
    }

    final rawProduct = json['product'];
    final extractedProductId = rawProduct is Map<String, dynamic>
        ? (rawProduct['_id']?.toString() ?? '')
        : (rawProduct?.toString() ?? '');

    return ReviewModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      productId: extractedProductId,
      userName: extractedName,
      comment: (json['comment'] ?? json['description'] ?? '').toString(),
      rating: (json['rating'] ?? 5).toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }
}
