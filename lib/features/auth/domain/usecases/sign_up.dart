import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SignUp implements UseCase<String, SignUpParams> {
  final AuthRepository authRepository;

  const SignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(SignUpParams params) async {
    return await authRepository.signUp(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
      phone: params.phone,
      city: params.city,
    );
  }
}

class SignUpParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String city;

  const SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.city,
  });
}
