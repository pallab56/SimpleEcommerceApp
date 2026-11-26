import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/wishlist_item.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlist implements UseCase<List<WishlistItem>, NoParams> {
  final WishlistRepository wishlistRepository;

  const GetWishlist(this.wishlistRepository);

  @override
  Future<Either<Failure, List<WishlistItem>>> call(NoParams params) {
    return wishlistRepository.getWishlist();
  }
}
