// CreateReview use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/review.dart';
import '../repositories/product_repository.dart';

class CreateReview implements UseCase<Review, CreateReviewParams> {
  final ProductRepository productRepository;

  const CreateReview(this.productRepository);

  @override
  Future<Either<Failure, Review>> call(CreateReviewParams params) {
    return productRepository.createReview(
      productId: params.productId,
      comment: params.comment,
      rating: params.rating,
    );
  }
}

class CreateReviewParams {
  final String productId;
  final String comment;
  final double rating;

  const CreateReviewParams({
    required this.productId,
    required this.comment,
    required this.rating,
  });
}
