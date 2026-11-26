// CartRepositoryImpl
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  const CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      final items = await remoteDataSource.getCartItems();
      return right(items);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToCart({
    required String productId,
    required int quantity,
    String? color,
    String? size,
  }) async {
    try {
      await remoteDataSource.addToCart(
        productId: productId,
        quantity: quantity,
        color: color,
        size: size,
      );
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCartQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      await remoteDataSource.updateCartQuantity(
        cartItemId: cartItemId,
        quantity: quantity,
      );
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart(String cartItemId) async {
    try {
      await remoteDataSource.removeFromCart(cartItemId);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
