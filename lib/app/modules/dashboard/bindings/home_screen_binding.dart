

import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';

import '../../../export.dart';




class HomeScreenBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(
          () => HomeScreenController(),
    );
  }
}
