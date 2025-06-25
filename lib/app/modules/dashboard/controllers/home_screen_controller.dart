


import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../export.dart';
import '/app/core/base/base_controller.dart';

class HomeScreenController extends BaseController {

  TextEditingController? emailController;

  final List tabs=["Collect Stamp","Unique Code","Invite Friends","Spin a Wheel"];

  final List resturants=["Starbucks","McDonals","Hermer","Burger King","Hungry Point"];



  FocusNode? emailFocusNode;


  @override
  void onInit() {


    super.onInit();
  }







  void skipPage() {

    // Get.offAllNamed(AppRoutes.mainScreenRoute);
  }

  @override
  void dispose() {
    _disposeEditTextController();
    _disposeFocusNode();
    super.dispose();
  }

  /*======================= dispose all edit text controllers that are used =======================*/

  _disposeEditTextController() {

    emailController?.dispose();

  }

  /*======================= dispose all focus nodes that are used in this controller =================*/

  _disposeFocusNode() {

    emailFocusNode?.dispose();

  }
}
