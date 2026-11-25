import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  static const String _tokenKey = 'auth_token';

  Future<void> _saveToken(String? token) async {
    if (token != null && token.isNotEmpty) {
      await sharedPreferences.setString(_tokenKey, token);
    }
  }

  @override
  Future<Either<Failure, String>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String city,
  }) async {
    try {
      final message = await remoteDataSource.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phone,
        city: city,
      );
      return right(message);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      await _saveToken(user.token);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> sendOtp({
    required String email,
  }) async {
    try {
      final message = await remoteDataSource.sendOtp(email: email);
      return right(message);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final user = await remoteDataSource.verifyOtp(
        email: email,
        otp: otp,
      );
      await _saveToken(user.token);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}


