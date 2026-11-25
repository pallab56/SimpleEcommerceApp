// VerifyOtp use case — validates the 4-digit OTP.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp implements UseCase<User, VerifyOtpParams> {
  final AuthRepository authRepository;

  const VerifyOtp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(VerifyOtpParams params) async {
    return await authRepository.verifyOtp(
      email: params.email,
      otp: params.otp,
    );
  }
}

class VerifyOtpParams {
  final String email;
  final String otp;

  const VerifyOtpParams({
    required this.email,
    required this.otp,
  });
}
