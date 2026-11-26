// WishlistRepositoryImpl
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/wishlist_item.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_remote_data_source.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  const WishlistRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<WishlistItem>>> getWishlist() async {
    try {
      final items = await remoteDataSource.getWishlist();
      return right(items);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addToWishlist(String productId) async {
    try {
      await remoteDataSource.addToWishlist(productId);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromWishlist(
    String wishlistItemId,
  ) async {
    try {
      await remoteDataSource.removeFromWishlist(wishlistItemId);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
