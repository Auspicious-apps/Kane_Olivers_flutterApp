

import '../../../export.dart';
import '../controllers/login_Controller.dart';



class LoginBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
  }
}
