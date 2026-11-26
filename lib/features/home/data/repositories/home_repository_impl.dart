// HomeRepositoryImpl — implements HomeRepository.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    try {
      final data = await remoteDataSource.getHomeData();
      return right(data);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
