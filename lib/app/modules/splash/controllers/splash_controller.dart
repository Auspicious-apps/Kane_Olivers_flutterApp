/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'dart:async';
import 'package:get/get.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';

class SplashController extends GetxController {
  Timer? timer;
  bool isLoading = false;
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  @override
  void onInit() {
    _navigateToNextScreen();
    super.onInit();
  }

  void _navigateToNextScreen() async {
    timer = Timer(const Duration(seconds: 5), () {
      var isFirstCheck = _localStorage.getFirstLaunch() ?? true;
      var token = _localStorage.getAuthToken();
      print(token);
      if (token != null) {
        Get.offNamed(AppRoutes.dashboard);
      } else if ((isFirstCheck == true)) {
        Get.offNamed(AppRoutes
            .onBoardingScreen); // Replace '/home' with your desired route;
      } else {
        Get.offNamed(AppRoutes.refferalScreen);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
