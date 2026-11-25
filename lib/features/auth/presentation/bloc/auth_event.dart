// AuthEvent
part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUpEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String city;

  const AuthSignUpEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.city,
  });
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

final class AuthSendOtpEvent extends AuthEvent {
  final String email;

  const AuthSendOtpEvent({required this.email});
}

final class AuthVerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;

  const AuthVerifyOtpEvent({
    required this.email,
    required this.otp,
  });
}
