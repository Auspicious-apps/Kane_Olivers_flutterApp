

import 'package:OLIVERS/app/modules/AuthModule/controllers/confirm_password_controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';

import '../../../export.dart';
import '../controller/changePasswordController.dart';



class Changepasswordbindings  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Changepasswordcontroller>(
          () => Changepasswordcontroller(),
    );
  }
}
