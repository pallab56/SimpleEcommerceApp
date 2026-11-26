// AddToCart use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

class AddToCart implements UseCase<Unit, AddToCartParams> {
  final CartRepository cartRepository;

  const AddToCart(this.cartRepository);

  @override
  Future<Either<Failure, Unit>> call(AddToCartParams params) {
    return cartRepository.addToCart(
      productId: params.productId,
      quantity: params.quantity,
      color: params.color,
      size: params.size,
    );
  }
}

class AddToCartParams {
  final String productId;
  final int quantity;
  final String? color;
  final String? size;

  const AddToCartParams({
    required this.productId,
    this.quantity = 1,
    this.color,
    this.size,
  });
}
