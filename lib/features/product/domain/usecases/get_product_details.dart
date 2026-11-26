// GetProductDetails use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_details.dart';
import '../repositories/product_repository.dart';

class GetProductDetails implements UseCase<ProductDetails, String> {
  final ProductRepository productRepository;

  const GetProductDetails(this.productRepository);

  @override
  Future<Either<Failure, ProductDetails>> call(String productId) {
    return productRepository.getProductDetails(productId);
  }
}
