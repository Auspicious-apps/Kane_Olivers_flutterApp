

import '../../../export.dart';
import '../controller/notification_controller.dart';
import '../controller/top_leader_privacy_setting_controller.dart';




class NotificationBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
          () => NotificationController(),
    );
  }
}
