


import 'package:OLIVERS/app/modules/dashboard/controllers/setting_screen_controller.dart';

import '../../../export.dart';




class SettingScreenBindings  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingScreenController>(
          () => SettingScreenController(),
    );
  }
}
