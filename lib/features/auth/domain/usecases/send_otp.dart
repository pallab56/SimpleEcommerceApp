// SendOtp use case — triggers OTP delivery to user's email/phone.
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SendOtp implements UseCase<String, SendOtpParams> {
  final AuthRepository authRepository;

  const SendOtp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(SendOtpParams params) async {
    return await authRepository.sendOtp(email: params.email);
  }
}

class SendOtpParams {
  final String email;

  const SendOtpParams({required this.email});
}
