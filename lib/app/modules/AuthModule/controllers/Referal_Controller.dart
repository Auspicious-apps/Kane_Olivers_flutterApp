


import '../../../export.dart';
import '/app/core/base/base_controller.dart';

class ReferalController extends BaseController {
  TextEditingController? refferalCodeController;
  FocusNode? RefferalCodeFocusNode;
  final signupFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    _initEditTextController();
    _initFocusNode();
    super.onInit();
  }

  _initEditTextController() {
    refferalCodeController = TextEditingController();

  }

  _initFocusNode() {
    RefferalCodeFocusNode = FocusNode();

  }

  void moveToSignUpPage(){

    // Get.offAllNamed(AppRoutes.signupRoute);

  }


  void skipPage() {
    Get.offAllNamed(AppRoutes.signUpRoute);
  }

  @override
  void dispose() {
    _disposeEditTextController();
    _disposeFocusNode();
    super.dispose();
  }

  /*======================= dispose all edit text controllers that are used =======================*/

  _disposeEditTextController() {
    refferalCodeController?.dispose();

  }

  /*======================= dispose all focus nodes that are used in this controller =================*/

  _disposeFocusNode() {
    RefferalCodeFocusNode?.dispose();

  }
}
