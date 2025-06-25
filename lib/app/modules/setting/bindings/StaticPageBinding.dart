


import 'package:OLIVERS/app/modules/setting/controller/staticPageController.dart';

import '../../../export.dart';
import '../controller/changePasswordController.dart';



class Staticpagebinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Staticpagecontroller>(
          () => Staticpagecontroller(),
    );
  }
}
