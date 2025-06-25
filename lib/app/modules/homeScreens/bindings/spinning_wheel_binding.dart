

import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';

import '../../../export.dart';
import '../controller/spinning_wheel_controller.dart';
class SpinningWheelBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpinningWheelController>(
          () => SpinningWheelController(),
    );
  }
}
