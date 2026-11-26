import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_details.dart';
import '../entities/review.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, ProductDetails>> getProductDetails(String productId);

  Future<Either<Failure, List<Review>>> getProductReviews(String productId);

  Future<Either<Failure, Review>> createReview({
    required String productId,
    required String comment,
    required double rating,
  });
}
