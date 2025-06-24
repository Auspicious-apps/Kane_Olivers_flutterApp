

import '../../../export.dart';
import '../controllers/Referal_Controller.dart';


class RefferalBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferalController>(
          () => ReferalController(),
    );
  }
}
