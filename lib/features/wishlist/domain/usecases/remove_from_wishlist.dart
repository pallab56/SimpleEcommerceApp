// RemoveFromWishlist use case.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/wishlist_repository.dart';

class RemoveFromWishlist implements UseCase<Unit, String> {
  final WishlistRepository wishlistRepository;

  const RemoveFromWishlist(this.wishlistRepository);

  @override
  Future<Either<Failure, Unit>> call(String wishlistItemId) {
    return wishlistRepository.removeFromWishlist(wishlistItemId);
  }
}
