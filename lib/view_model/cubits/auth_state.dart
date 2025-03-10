part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class ChangeTabState extends AuthState {}

class ChangeRememberMeState extends AuthState {}

class ClearDataState extends AuthState {}

final class ChangePasswordVisibilityState extends AuthState {}

class OtpTimerStartedState extends AuthState {}

class OtpTimerUpdatedState extends AuthState {
  final int remainingTime;

  OtpTimerUpdatedState(this.remainingTime);
}

class OtpTimerFinishedState extends AuthState {}

final class ResendOtpLoadingState extends AuthState {}

final class ResendOtpSuccessState extends AuthState {}

final class ResendOtpErrorState extends AuthState {
  final String msg;

  ResendOtpErrorState(this.msg);
}
