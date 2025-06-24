

import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/setting_screen_controller.dart';

import '../../../export.dart';

class BottomTabBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => SettingScreenController());

  }
}