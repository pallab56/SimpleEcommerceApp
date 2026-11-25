// AuthRepository — abstract contract for auth operations.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String city,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> sendOtp({
    required String email,
  });

  Future<Either<Failure, User>> verifyOtp({
    required String email,
    required String otp,
  });
}
