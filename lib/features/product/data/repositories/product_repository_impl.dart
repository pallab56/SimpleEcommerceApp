import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product_details.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  const ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductDetails>> getProductDetails(
    String productId,
  ) async {
    try {
      final product = await remoteDataSource.getProductDetails(productId);
      return right(product);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Review>>> getProductReviews(
    String productId,
  ) async {
    try {
      final reviews = await remoteDataSource.getProductReviews(productId);
      return right(reviews);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Review>> createReview({
    required String productId,
    required String comment,
    required double rating,
  }) async {
    try {
      final review = await remoteDataSource.createReview(
        productId: productId,
        comment: comment,
        rating: rating,
      );
      return right(review);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
