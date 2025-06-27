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
import 'package:OLIVERS/app/modules/Myprofile/dart/binding/dart/profile_binding.dart';
import 'package:OLIVERS/app/modules/Myprofile/dart/view%20/profile.dart';
import 'package:OLIVERS/app/modules/homeScreens/bindings/Resturant_bindings.dart';
import 'package:OLIVERS/app/modules/homeScreens/bindings/offer_detail_binding.dart';
import 'package:OLIVERS/app/modules/homeScreens/bindings/offers_binding.dart';
import 'package:OLIVERS/app/modules/homeScreens/bindings/spinning_wheel_binding.dart';
import 'package:OLIVERS/app/modules/homeScreens/views/ResturantScreen.dart';
import 'package:OLIVERS/app/modules/homeScreens/views/offer_detail_screen.dart';
import 'package:OLIVERS/app/modules/homeScreens/views/offers_screen.dart';
import 'package:OLIVERS/app/modules/homeScreens/views/spinning_wheel.dart';
import 'package:OLIVERS/app/modules/setting/bindings/changePasswordBindings.dart';
import 'package:OLIVERS/app/modules/setting/views/staticPage.dart';
import 'package:OLIVERS/app/modules/splash/bindings/welcome_binding.dart';
import 'package:OLIVERS/app/modules/splash/views/onboarding.dart';


import '../modules/bottom_tab/bindings/bottom_tab_binding.dart';
import '../modules/bottom_tab/views/bottom_tab.dart';
import '../modules/setting/bindings/StaticPageBinding.dart';
import '../modules/setting/bindings/notification_binding.dart';
import '../modules/setting/bindings/top_leader_privacy_setting_binding.dart';
import '../modules/setting/views/changePassword.dart';
import '../modules/setting/views/notifications.dart';
import '../modules/setting/views/top_leaders_privacy_setting.dart';
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
    GetPage(
      name: AppRoutes.changePassword,
      page: () =>  Changepassword(),
      bindings: [Changepasswordbindings()],
    ),
    GetPage(
      name: AppRoutes.StaticPage,
      page: () =>  Staticpage(),
      bindings: [Staticpagebinding()],
    ),
    GetPage(
      name: AppRoutes.TopLeadersSettingRoute,
      page: () =>  TopLeadersPrivacySetting(),
      bindings: [TopLeaderPrivacySettingBinding()],
    ),
    GetPage(
      name: AppRoutes.NotificationRoute,
      page: () =>  Notifications(),
      bindings: [NotificationBinding()],

    ),

    GetPage(
      name: AppRoutes.SpinWheelRoute,
      page: () =>  SpinningWheel(),
      bindings: [SpinningWheelBinding()],

    ),

    GetPage(
      name: AppRoutes.ResturantRoute,
      page: () =>  Resturantscreen(),
      bindings: [ResturantBindings()],

    ),
    GetPage(
      name: AppRoutes.OffersRoute,
      page: () =>  OffersScreen(),
      bindings: [OffersBinding()],

    ),

    GetPage(
      name: AppRoutes.OffersDetails,
      page: () =>  OfferDetailScreen(),
      bindings: [OfferDetailBinding()],

    ),
    GetPage(
      name: AppRoutes.Profile,
      page: () =>  Profile(),
      bindings: [ProfileBinding()],

    ),
  ];
}
