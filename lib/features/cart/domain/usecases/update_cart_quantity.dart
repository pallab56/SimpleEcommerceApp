// UpdateCartQuantity use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

class UpdateCartQuantity implements UseCase<Unit, UpdateCartQuantityParams> {
  final CartRepository cartRepository;

  const UpdateCartQuantity(this.cartRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateCartQuantityParams params) {
    return cartRepository.updateCartQuantity(
      cartItemId: params.cartItemId,
      quantity: params.quantity,
    );
  }
}

class UpdateCartQuantityParams {
  final String cartItemId;
  final int quantity;

  const UpdateCartQuantityParams({
    required this.cartItemId,
    required this.quantity,
  });
}
