// GetProductReviews use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/review.dart';
import '../repositories/product_repository.dart';

class GetProductReviews implements UseCase<List<Review>, String> {
  final ProductRepository productRepository;

  const GetProductReviews(this.productRepository);

  @override
  Future<Either<Failure, List<Review>>> call(String productId) {
    return productRepository.getProductReviews(productId);
  }
}
