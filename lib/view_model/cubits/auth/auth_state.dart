part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class ChangeTabState extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {
  final String msg;

  LoginErrorState(this.msg);
}

final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterErrorState extends AuthState {
  final String msg;

  RegisterErrorState(this.msg);
}

final class GetUserDataLoadingState extends AuthState {}

final class GetUserDataSuccessState extends AuthState {}

final class GetUserDataErrorState extends AuthState {
  final String msg;

  GetUserDataErrorState(this.msg);
}

final class GetUserAddressLoadingState extends AuthState {}

final class GetUserAddressSuccessState extends AuthState {}

final class GetUserAddressErrorState extends AuthState {
  final String msg;

  GetUserAddressErrorState(this.msg);
}final class AddAddressLoadingState extends AuthState {}

final class AddAddressSuccessState extends AuthState {}

final class AddAddressErrorState extends AuthState {
  final String msg;

  AddAddressErrorState(this.msg);
}

final class ChangeProfilePictureLoadingState extends AuthState {}

final class ChangeProfilePictureSuccessState extends AuthState {}

final class ChangeProfilePictureErrorState extends AuthState {
  final String msg;

  ChangeProfilePictureErrorState(this.msg);
}

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

class LogoutSuccessState extends AuthState {}
