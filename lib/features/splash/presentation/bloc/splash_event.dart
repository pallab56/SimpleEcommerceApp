// SplashEvent
part of 'splash_bloc.dart';

sealed class SplashEvent {
  const SplashEvent();
}

final class CheckAuthStatusEvent extends SplashEvent {
  const CheckAuthStatusEvent();
}
