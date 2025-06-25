


import 'package:OLIVERS/app/modules/setting/controller/staticPageController.dart';

import '../../../export.dart';
import '../controller/top_leader_privacy_setting_controller.dart';




class TopLeaderPrivacySettingBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopLeaderPrivacySettingController>(
          () => TopLeaderPrivacySettingController(),
    );
  }
}
