
import '../../../../../export.dart';
import '../../controller/dart/profile_controller.dart';


class ProfileBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
