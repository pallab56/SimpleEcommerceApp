// WishlistRepository — abstract contract.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/wishlist_item.dart';

abstract interface class WishlistRepository {
  Future<Either<Failure, List<WishlistItem>>> getWishlist();
  Future<Either<Failure, Unit>> addToWishlist(String productId);
  Future<Either<Failure, Unit>> removeFromWishlist(String wishlistItemId);
}
