


import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../export.dart';
import '/app/core/base/base_controller.dart';

class Changepasswordcontroller extends BaseController {

  RxBool isloading=false.obs;
  final signupFormKey = GlobalKey<FormState>();
  final PasswordTextController =TextEditingController();
  final PasswordFocusNode=FocusNode();
  final ConfirmPasswordTextController =TextEditingController();
  final ConfirmPasswordFocusNode=FocusNode();

  final OldPasswordTextController =TextEditingController();
  final OldPasswordFocusNode=FocusNode();
  RxBool ShowPassword=false.obs;
  RxBool ShowOldPassword=false.obs;

  var otp ="".obs;

  RxBool ShowConfirmPassword=false.obs;

  @override
  void onInit() {
    if(Get.arguments!=null){
      otp.value=Get.arguments["otp"];
    }
    super.onInit();
  }



  handleForgetSubmit(var data,BuildContext context) {
    isloading.value=true;
    isloading.refresh();
    try{
      repository.UpdatePasswordApi(dataBody: data).then((value) async {
        if (value != null) {
          isloading.value=false;
          isloading.refresh();
          Get.back();
          Get.closeAllSnackbars();
          Get.snackbar('Success', 'Change Password Successfully');


        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value=false;
        isloading.refresh();
        Get.snackbar('Error', '${er}');
      });
    }catch(er){
      isloading.value=false;
      isloading.refresh();
      print("$er");
    }
  }




  Widget _buildOtpModalContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            confirmicon,
            height: 50,
            width: 70,
          ),
          TextView(
            textAlign: TextAlign.center,
            text: "Updated Password Successfully!",
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "TOMMYSOFT",
                fontSize: 20,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10),
          SizedBox(height: 20.0),
          MaterialButtonWidget(
            buttonBgColor: AppColors.LargeTextColor,
            buttonRadius: Get.width * 0.1, // Relative to screen width
            buttonText: "Oky",
            textColor: AppColors.backgroundColor,
            onPressed: () {
              Get.offAllNamed(AppRoutes.LoginRoute);


            },
          ).marginSymmetric(horizontal: margin_50)
        ],
      ),
    );
  }


  void skipPage() {

    // Get.offAllNamed(AppRoutes.mainScreenRoute);
  }

  @override
  void dispose() {

    super.dispose();
  }


}
