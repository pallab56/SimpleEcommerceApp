// AppUserState — states: AppUserInitial, AppUserLoggedIn.
part of 'app_user_cubit.dart';

sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {
  const AppUserInitial();
}

final class AppUserLoggedIn extends AppUserState {
  final User user;

  const AppUserLoggedIn(this.user);
}
