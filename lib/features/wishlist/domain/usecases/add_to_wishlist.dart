import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/wishlist_repository.dart';

class AddToWishlist implements UseCase<Unit, String> {
  final WishlistRepository wishlistRepository;

  const AddToWishlist(this.wishlistRepository);

  @override
  Future<Either<Failure, Unit>> call(String productId) {
    return wishlistRepository.addToWishlist(productId);
  }
}
