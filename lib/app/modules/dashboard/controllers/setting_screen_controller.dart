


import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';
import '../../AuthModule/models/responsemodels/userResponseModel.dart';
import '/app/core/base/base_controller.dart';

class SettingScreenController extends BaseController {
  final LocalStorage localStorage = LocalStorage();
  TextEditingController? emailController;

  UserResponseModel? userResponseModel;



  FocusNode? emailFocusNode;


  @override
  void onInit() {


    super.onInit();
  }



  handleSubmit() {
    try {
      repository.LogOutApi().then((value) async {
        if (value != null) {
          userResponseModel = value;
          localStorage.clearLoginData();
          Get.offAllNamed(AppRoutes.signUpRoute);
          Get.snackbar('Success', '${userResponseModel?.message}');
        }
      }).onError((er, stackTrace) {
        print("$er");

        Get.snackbar('Error', '${er}');
      });
    } catch (er) {

      print("$er");
    }
  }


  void skipPage() {

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
