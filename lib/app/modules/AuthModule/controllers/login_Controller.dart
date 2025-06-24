import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';
import '../models/responsemodels/userResponseModel.dart';
import '/app/core/base/base_controller.dart';

class LoginController extends BaseController {
  UserResponseModel? userResponseModel;
  TextEditingController? emailController;
  final PasswordTextController = TextEditingController();
  final PasswordFocusNode = FocusNode();
  final LocalStorage _localStorage = LocalStorage();
  RxBool ShowPassword = false.obs;

  final loginFormKey = GlobalKey<FormState>();
  RxBool isloading = false.obs;
  FocusNode? emailFocusNode;

  var selectGender = "".obs;
  @override
  void onInit() {
    _initEditTextController();
    _initFocusNode();

    super.onInit();
  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      repository.LoginApi(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          if (userResponseModel?.data?.token != null) {
            _localStorage.saveAuthToken(userResponseModel?.data?.token);
          }
          isloading.value = false;
          isloading.refresh();
          if (userResponseModel?.data?.user?.isVerified == true) {
            Get.toNamed(AppRoutes.dashboard);
          } else {
            Get.toNamed(AppRoutes.otpVerificationRoute);
          }
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

  _initEditTextController() {
    emailController = TextEditingController();
  }

  _initFocusNode() {
    emailFocusNode = FocusNode();
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
