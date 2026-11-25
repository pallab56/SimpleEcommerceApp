// UseCase<SuccessType, Params> — base interface for all domain use cases.
import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {
  const NoParams();
}
