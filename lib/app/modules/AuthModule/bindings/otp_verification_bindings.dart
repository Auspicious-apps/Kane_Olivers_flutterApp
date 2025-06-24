

import 'package:OLIVERS/app/modules/AuthModule/controllers/otp_verification_controller.dart';

import '../../../export.dart';
import '../controllers/login_Controller.dart';



class OtpVerificationBindings  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationController>(
          () => OtpVerificationController(),
    );
  }
}
