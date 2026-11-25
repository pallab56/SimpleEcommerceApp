import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/verify_otp.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUp;
  final UserLogin _userLogin;
  final SendOtp _sendOtp;
  final VerifyOtp _verifyOtp;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required SignUp signUp,
    required UserLogin userLogin,
    required SendOtp sendOtp,
    required VerifyOtp verifyOtp,
    required AppUserCubit appUserCubit,
  })  : _signUp = signUp,
        _userLogin = userLogin,
        _sendOtp = sendOtp,
        _verifyOtp = verifyOtp,
        _appUserCubit = appUserCubit,
        super(const AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(const AuthLoading()));
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthLoginEvent>(_onLogin);
    on<AuthSendOtpEvent>(_onSendOtp);
    on<AuthVerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onSignUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _signUp(
      SignUpParams(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        phone: event.phone,
        city: event.city,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (message) => emit(AuthSignUpSuccess(message: message, email: event.email)),
    );
  }

  Future<void> _onLogin(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  Future<void> _onSendOtp(
    AuthSendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _sendOtp(SendOtpParams(email: event.email));

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (message) => emit(AuthOtpSentSuccess(message)),
    );
  }

  Future<void> _onVerifyOtp(
    AuthVerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _verifyOtp(
      VerifyOtpParams(
        email: event.email,
        otp: event.otp,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
