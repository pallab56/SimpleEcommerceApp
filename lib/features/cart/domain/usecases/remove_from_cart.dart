// RemoveFromCart use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCart implements UseCase<Unit, String> {
  final CartRepository cartRepository;

  const RemoveFromCart(this.cartRepository);

  @override
  Future<Either<Failure, Unit>> call(String cartItemId) {
    return cartRepository.removeFromCart(cartItemId);
  }
}
