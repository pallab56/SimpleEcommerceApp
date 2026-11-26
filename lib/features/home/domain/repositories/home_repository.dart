// HomeRepository — abstract contract.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/home_data.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, HomeData>> getHomeData();
}
