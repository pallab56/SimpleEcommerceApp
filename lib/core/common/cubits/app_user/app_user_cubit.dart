// AppUserCubit — holds the global authenticated user state.
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/auth/domain/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(const AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(const AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }

  /// Helper to read the current logged-in user (or null if logged out)
  User? get currentUser {
    final currentState = state;
    if (currentState is AppUserLoggedIn) {
      return currentState.user;
    }
    return null;
  }

  /// Helper to quickly grab the JWT token for authenticated API calls
  String? get token => currentUser?.token;
}
