/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'package:OLIVERS/app/export.dart';
import 'package:OLIVERS/app/modules/AuthModule/bindings/confirm_password_binding.dart';
import 'package:OLIVERS/app/modules/AuthModule/bindings/forget_binding.dart';
import 'package:OLIVERS/app/modules/AuthModule/bindings/login_binding.dart';
import 'package:OLIVERS/app/modules/AuthModule/bindings/otp_verification_bindings.dart';
import 'package:OLIVERS/app/modules/AuthModule/bindings/refferal_binding.dart';
import 'package:OLIVERS/app/modules/AuthModule/bindings/signup_binding.dart';
import 'package:OLIVERS/app/modules/AuthModule/views/Login_Screen.dart';
import 'package:OLIVERS/app/modules/AuthModule/views/RefferalScreen.dart';
import 'package:OLIVERS/app/modules/AuthModule/views/confirm_password.dart';
import 'package:OLIVERS/app/modules/AuthModule/views/forget_password.dart';
import 'package:OLIVERS/app/modules/AuthModule/views/otp_verification.dart';
import 'package:OLIVERS/app/modules/AuthModule/views/signup_Screen.dart';
import 'package:OLIVERS/app/modules/splash/bindings/welcome_binding.dart';
import 'package:OLIVERS/app/modules/splash/views/onboarding.dart';


import '../modules/bottom_tab/bindings/bottom_tab_binding.dart';
import '../modules/bottom_tab/views/bottom_tab.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_screen.dart';



class AppPages {
  static const INITIAL = AppRoutes.splashRoute;

  static final routes = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashView(),
      bindings: [SplashBinding()],
    ),
    GetPage(
      name: AppRoutes.onBoardingScreen,
      page: () => const OnBoardingView(),
      bindings: [OnBoardingBinding()],
    ),
    GetPage(
      name: AppRoutes.refferalScreen,
      page: () => const Refferalscreen(),
      bindings: [RefferalBinding()],
    ),
    GetPage(
      name: AppRoutes.signUpRoute,
      page: () => const SignupScreen(),
      bindings: [SignupBinding()],
    ),
    GetPage(
      name: AppRoutes.LoginRoute,
      page: () => const LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: AppRoutes.forgetRoute,
      page: () => const ForgetPassword(),
      bindings: [ForgetBinding()],
    ),
    GetPage(
      name: AppRoutes.otpVerificationRoute,
      page: () => const OtpVerification(),
      bindings: [OtpVerificationBindings()],
    ),
    GetPage(
      name: AppRoutes.confirmPasswordRoute,
      page: () => const ConfirmPassword(),
      bindings: [ConfirmPasswordBinding()],
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () =>  BottomTab(),
      bindings: [BottomTabBinding()],
    ),
  ];
}
