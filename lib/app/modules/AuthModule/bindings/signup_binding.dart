

import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';

import '../../../export.dart';
import '../controllers/Referal_Controller.dart';


class SignupBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
          () => SignUpController(),
    );
  }
}
