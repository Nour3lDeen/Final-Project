import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/user/user.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/data/local/shared_helper.dart';
import '../../utils/data/local/shared_keys.dart';
import '../../utils/data/network/dio_helper.dart';
import '../../utils/data/network/endpoints.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  User? user;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> createNewPasswordFormKey = GlobalKey<FormState>();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController =
      TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();

  TextEditingController forgetPasswordEmailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  TextEditingController createNewPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();

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

  void viewToast(
      String message, BuildContext context, Color color, int? duration) {
    showToast(message,
        context: context,
        backgroundColor: color,
        position: StyledToastPosition.bottom,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: Duration(seconds: duration ?? 2),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        borderRadius: BorderRadius.circular(25.r),
        isHideKeyboard: true,
        textStyle: TextStyle(
          color: AppColors.white,
          fontSize: 12.sp,
          fontFamily: 'Poppins',
        ));
  }

  void login() async {
    debugPrint('Attempting login...');
    emit(LoginLoadingState());

    await DioHelper.post(
      path: EndPoints.login,
      body: {
        'email': loginEmailController.text,
        'password': loginPasswordController.text,
      },
    ).then((value) {
      debugPrint('Response: ${value.data}');

      if (value.data != null && value.statusCode == 200) {
        // Extract token directly
        final token = value.data['token'];

        // Create user from the flat response
        user = User(
          firstName: value.data['fName'],
          lastName: value.data['lName'],
          email: value.data['email'],
          avatar: value.data['userPictureUrl'],
          mobile: '',
        );

        // Save user details in shared preferences
        SharedHelper.saveData(SharedKeys.firstName, user!.firstName);
        SharedHelper.saveData(SharedKeys.secondName, user!.lastName);
        SharedHelper.saveData(SharedKeys.avatar, user!.avatar);
        SharedHelper.saveData(SharedKeys.email, user!.email);
        SharedHelper.saveData(SharedKeys.phone, user!.mobile);
        SharedHelper.saveData(SharedKeys.token, token);

        debugPrint('Token: $token');
        debugPrint('User: ${user.toString()}');
        // Handle    remember me toggle
        if (rememberMe) {
          SharedHelper.saveData(SharedKeys.isLogged, true);
          debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
        } else {
          SharedHelper.saveData(SharedKeys.isLogged, false);
          debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
        }

        clearData();
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState('Error logging in'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');

      if (error is DioException) {
        if (error.response != null && error.response!.statusCode! >= 500) {
          final errorMessage = 'Error in server';
          emit(LoginErrorState(errorMessage));
          debugPrint('Error1: $errorMessage');
        } else if (error.response != null &&
            error.response!.statusCode! >= 400 &&
            error.response!.statusCode! < 500) {
          final errorMessage = 'Error logging in';
          emit(LoginErrorState(errorMessage));
          debugPrint('Error2: $errorMessage');
        }
      }
    });
  }

  void register() {
    emit(RegisterLoadingState());
    DioHelper.post(
      path: EndPoints.register,
      body: {
        'email': registerEmailController.text,
        'fName': firstNameController.text,
        'lName': secondNameController.text,
        'phoneNumber': registerPhoneController.text,
        'password': registerPasswordController.text,
        'rePassword': registerConfirmPasswordController.text
      },
    ).then((value) {
      debugPrint('Response: ${value.data}');

      if (value.data != null && value.statusCode == 200) {
        final token = value.data['token'];

        user = User(
          firstName: value.data['fName'],
          lastName: value.data['lName'],
          email: value.data['email'],
          avatar: value.data['userPictureUrl'],
          mobile: value.data['phoneNumber'],
        );

        // Save user details in shared preferences
        SharedHelper.saveData(SharedKeys.firstName, user!.firstName);
        SharedHelper.saveData(SharedKeys.secondName, user!.lastName);
        SharedHelper.saveData(SharedKeys.avatar, user!.avatar);
        SharedHelper.saveData(SharedKeys.email, user!.email);
        SharedHelper.saveData(SharedKeys.phone, user!.mobile);
        SharedHelper.saveData(SharedKeys.token, token);

        debugPrint('Token: $token');
        debugPrint('User: ${user.toString()}');
        // Handle    remember me toggle
        if (rememberMe) {
          SharedHelper.saveData(SharedKeys.isLogged, true);
          debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
        } else {
          SharedHelper.saveData(SharedKeys.isLogged, false);
          debugPrint('isLogged: ${SharedHelper.getData(SharedKeys.isLogged)}');
        }

        clearData();
        emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState('Error Signing up'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');

      if (error is DioException) {
        if (error.response != null && error.response!.statusCode! >= 500) {
          final errorMessage = 'Error in server';
          emit(RegisterErrorState(errorMessage));
          debugPrint('Error1: $errorMessage');
        } else if (error.response != null &&
            error.response!.statusCode! >= 400 &&
            error.response!.statusCode! < 500) {
          final errorMessage = 'Error Signing up';
          emit(RegisterErrorState(errorMessage));
          debugPrint('Error2: $errorMessage');
        }
      }
    });
  }

  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.get(path: EndPoints.profile, withToken: true).then((value) {
      debugPrint('Response: ${value.data}');

      if (value.data != null && value.statusCode == 200) {
        final token = value.data['token'];

        user = User(
          firstName: value.data['fName'],
          lastName: value.data['lName'],
          email: value.data['email'],
          avatar: value.data['userPictureUrl'],
          mobile: value.data['phoneNumber'],
        );

        // Save user details in shared preferences
        SharedHelper.saveData(SharedKeys.firstName, user!.firstName);
        SharedHelper.saveData(SharedKeys.secondName, user!.lastName);
        SharedHelper.saveData(SharedKeys.avatar, user!.avatar);
        SharedHelper.saveData(SharedKeys.email, user!.email);
        SharedHelper.saveData(SharedKeys.phone, user!.mobile);
        SharedHelper.saveData(SharedKeys.token, token);

        debugPrint('Token: $token');
        debugPrint('User: ${user.toString()}');

        emit(GetUserDataSuccessState());
      } else {
        emit(GetUserDataErrorState('Error getting user data'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');
    });
  }

  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  void changeProfilePicture() async {
    try {
      // 1. Pick image from gallery
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Reduce image quality for faster upload
      );

      if (pickedFile == null) return; // User canceled

      emit(ChangeProfilePictureLoadingState());

      // 2. Create File object
      profileImage = File(pickedFile.path);
      emit(ChangeProfilePictureLoadingState()); // Show loading with new image

      // 3. Prepare multipart request
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          profileImage!.path,
          filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });

      // 4. Upload to server
      final response = await DioHelper.post(
        path: EndPoints.uploadUserPicture,
        body: formData,
        withToken: true,
      );

      if (response.statusCode == 200) {
        emit(ChangeProfilePictureSuccessState());
      } else {
        profileImage = null; // Remove the image if upload failed
        emit(ChangeProfilePictureErrorState('Upload failed'));
      }
    } on DioException catch (e) {
      profileImage = null;
      debugPrint('Dio Error: ${e.message}');
      emit(ChangeProfilePictureErrorState('Network error'));
    } catch (e) {
      profileImage = null;
      debugPrint('Error: $e');
      emit(ChangeProfilePictureErrorState('An error occurred'));
    }
  }

  void getUserAddress() {
    emit(GetUserAddressLoadingState());
    DioHelper.get(path: EndPoints.getAddress, withToken: true).then((value) {
      debugPrint('Response: ${value.data}');

      if (value.data != null && value.statusCode == 200) {
        SharedHelper.saveData(SharedKeys.city, value.data['city']);
        SharedHelper.saveData(SharedKeys.country, value.data['country']);
        SharedHelper.saveData(SharedKeys.street, value.data['street']);
        debugPrint('City ${SharedHelper.getData(SharedKeys.city)}');
        debugPrint('Street ${SharedHelper.getData(SharedKeys.street)}');
        debugPrint('Country ${SharedHelper.getData(SharedKeys.country)}');
        emit(GetUserAddressSuccessState());
      } else {
        emit(GetUserAddressErrorState('Error getting user address'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');
    });
  }

  void addAddress() {
    emit(AddAddressLoadingState());
    DioHelper.post(
            path: EndPoints.addAddress,
            body: {
              'city': cityController.text,
              'country': countryController.text,
              'street': streetController.text
            },
            withToken: true)
        .then((value) {
      debugPrint('Response: ${value.data}');

      if (value.data != null && value.statusCode == 200) {
        SharedHelper.saveData(SharedKeys.city, value.data['city']);
        SharedHelper.saveData(SharedKeys.country, value.data['country']);
        SharedHelper.saveData(SharedKeys.street, value.data['street']);
        debugPrint('City ${SharedHelper.getData(SharedKeys.city)}');
        debugPrint('Street ${SharedHelper.getData(SharedKeys.street)}');
        debugPrint('Country ${SharedHelper.getData(SharedKeys.country)}');
        emit(AddAddressSuccessState());
      } else {
        emit(AddAddressErrorState('Error getting user address'));
        debugPrint('Error: Response does not contain required fields.');
      }
    }).catchError((error) {
      debugPrint('Error type: ${error.runtimeType}');
      debugPrint('Error: $error');
    });
  }

  void logout() {
    SharedHelper.removeKey(SharedKeys.token);
    SharedHelper.removeKey(SharedKeys.isLogged);
    SharedHelper.removeKey(SharedKeys.firstName);
    SharedHelper.removeKey(SharedKeys.secondName);
    SharedHelper.removeKey(SharedKeys.avatar);
    SharedHelper.removeKey(SharedKeys.email);
    SharedHelper.removeKey(SharedKeys.phone);
    emit(LogoutSuccessState());
  }
}
