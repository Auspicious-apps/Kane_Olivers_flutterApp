

import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';

import '../../../export.dart';
import '../controllers/login_Controller.dart';



class ForgetBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetController>(
          () => ForgetController(),
    );
  }
}
