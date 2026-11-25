// AuthState
part of 'auth_bloc.dart';


sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSignUpSuccess extends AuthState {
  final String message;
  final String email;

  const AuthSignUpSuccess({required this.message, required this.email});
}

final class AuthOtpSentSuccess extends AuthState {
  final String message;

  const AuthOtpSentSuccess(this.message);
}

final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}
