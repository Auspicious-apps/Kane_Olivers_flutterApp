


import 'package:OLIVERS/app/modules/AuthModule/models/responsemodels/userResponseModel.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';
import '/app/core/base/base_controller.dart';

class SignUpController extends BaseController {
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController? refferalCodeController;
  FocusNode? RefferalCodeFocusNode;
  TextEditingController? emailController;
  final PasswordTextController =TextEditingController();
  final PasswordFocusNode=FocusNode();
  final ConfirmPasswordTextController =TextEditingController();
  final ConfirmPasswordFocusNode=FocusNode();
  final mobileNumberTextController =TextEditingController();
  final mobileNumberFocusNode=FocusNode();
  UserResponseModel? userResponseModel;
  RxBool ShowPassword=false.obs;
  final LocalStorage _localStorage = LocalStorage();
  RxBool Acceptterms=false.obs;
  RxBool ShowConfirmPassword=false.obs;
  RxBool isloading=false.obs;
  late Rx<Country> selectedCountry;

  FocusNode? emailFocusNode;
  final List<String> genders=["Male","Female","Others"];
  var selectGender = "".obs;
  var refferalcode = "".obs;
  @override
  void onInit() {
    _initEditTextController();
    if(Get.arguments!=null){
      refferalcode.value=Get.arguments['Referral'];
    }
    _initFocusNode();
    _loadCountry();
    super.onInit();
  }

  void _loadCountry() {
    final country = countries.firstWhere((item) => item.code == 'GB',
        orElse: () => countries.first);
    selectedCountry = country.obs;
  }



  handleSubmit(var data) {
    isloading.value=true;
    isloading.refresh();
    try{
      Get.closeAllSnackbars();
      repository.signupApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          // if (userResponseModel?.data?.token != null) {
          //   _localStorage.saveAuthToken(userResponseModel?.data?.token);
          // }
          isloading.value=false;
          isloading.refresh();
          Get.toNamed(AppRoutes.otpVerificationRoute,arguments: {"email":emailController?.text});
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value=false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '${er}');
      });
    }catch(er){
      isloading.value=false;
      isloading.refresh();
      print("$er");
    }
  }

  _initEditTextController() {
    refferalCodeController = TextEditingController();
    emailController = TextEditingController();

  }

  _initFocusNode() {
    RefferalCodeFocusNode = FocusNode();
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
    refferalCodeController?.dispose();
    emailController?.dispose();

  }

  /*======================= dispose all focus nodes that are used in this controller =================*/

  _disposeFocusNode() {
    RefferalCodeFocusNode?.dispose();
    emailFocusNode?.dispose();

  }
}
