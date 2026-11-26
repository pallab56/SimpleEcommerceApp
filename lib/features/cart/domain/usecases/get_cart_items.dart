// GetCartItems use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCartItems implements UseCase<List<CartItem>, NoParams> {
  final CartRepository cartRepository;

  const GetCartItems(this.cartRepository);

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) {
    return cartRepository.getCartItems();
  }
}
