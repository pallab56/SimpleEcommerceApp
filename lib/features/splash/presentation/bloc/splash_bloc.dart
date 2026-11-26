// SplashBloc — decides whether to route to auth or home.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SharedPreferences _sharedPreferences;

  SplashBloc({
    required SharedPreferences sharedPreferences,
  })  : _sharedPreferences = sharedPreferences,
        super(const SplashInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    final token = _sharedPreferences.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      emit(const SplashAuthenticated());
    } else {
      emit(const SplashUnauthenticated());
    }
  }
}
