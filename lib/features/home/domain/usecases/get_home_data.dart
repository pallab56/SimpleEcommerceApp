// GetHomeData use case — returns banners, categories, and featured products.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/home_data.dart';
import '../repositories/home_repository.dart';

class GetHomeData implements UseCase<HomeData, NoParams> {
  final HomeRepository homeRepository;

  const GetHomeData(this.homeRepository);

  @override
  Future<Either<Failure, HomeData>> call(NoParams params) async {
    return await homeRepository.getHomeData();
  }
}
