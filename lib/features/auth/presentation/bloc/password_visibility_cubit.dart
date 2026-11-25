import 'package:flutter_bloc/flutter_bloc.dart';

/// Simple Cubit that toggles password field visibility.
/// Replaces [setState] in EmailVerificationPage.
class PasswordVisibilityCubit extends Cubit<bool> {
  /// Initial state: password is hidden (true = obscure).
  PasswordVisibilityCubit() : super(true);

  void toggle() => emit(!state);
}
