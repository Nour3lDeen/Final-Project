import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> createNewPasswordFormKey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController =
      TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();

  TextEditingController forgetPasswordEmailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController createNewPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool showPassword = true;
  final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    caseSensitive: false,
  );
  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    emit(ChangeTabState());
  }

  bool rememberMe = false;

  void changeRememberMe() {
    rememberMe = !rememberMe;
    emit(ChangeRememberMeState());
  }

  int otpTimer = 60;
  bool canResendOtp = false;
  Timer? _otpTimer;

  void startOtpTimer() {
    otpTimer = 60;
    canResendOtp = false;
    emit(OtpTimerStartedState());

    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer > 0) {
        otpTimer--;
        emit(OtpTimerUpdatedState(otpTimer));
      } else {
        canResendOtp = true;
        _otpTimer?.cancel();
        emit(OtpTimerFinishedState());
      }
    });
  }
  void clearData() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    forgetPasswordEmailController.clear();
    otpController.clear();
    createNewPasswordController.clear();
    confirmPasswordController.clear();

    emit(ClearDataState());
  }

  bool validateEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  void changePasswordVisibility() {
    showPassword = !showPassword;
    emit(ChangePasswordVisibilityState());
  }
}
