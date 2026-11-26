// CartRepository — abstract contract.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_item.dart';

abstract interface class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCartItems();

  Future<Either<Failure, Unit>> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  });

  Future<Either<Failure, Unit>> updateCartQuantity({
    required String cartItemId,
    required int quantity,
  });

  Future<Either<Failure, Unit>> removeFromCart(String cartItemId);
}
