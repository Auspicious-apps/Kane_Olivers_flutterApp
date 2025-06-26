


import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';
import '../models/responsemodels/userResponseModel.dart';
import '/app/core/base/base_controller.dart';

class ForgetController extends BaseController {
  final LocalStorage localStorage = LocalStorage();
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController? emailController;
  final PasswordTextController =TextEditingController();
  final PasswordFocusNode=FocusNode();
  RxBool isloading = false.obs;

  UserResponseModel? userResponseModel;


  FocusNode? emailFocusNode;


  @override
  void onInit() {
    _initEditTextController();
    _initFocusNode();

    super.onInit();
  }



  _initEditTextController() {

    emailController = TextEditingController();

  }

  _initFocusNode() {

    emailFocusNode = FocusNode();

  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.ForgetPasswordApi(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          isloading.value = false;
          isloading.refresh();
          Get.toNamed(AppRoutes.otpVerificationRoute,arguments: {"email":emailController?.text});
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.snackbar('Error', '${er}');
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
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
