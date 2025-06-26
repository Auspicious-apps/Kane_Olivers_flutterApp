import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/validator.dart';
import '../models/requestmodel/request_models.dart';

class ForgetPassword extends GetView<ForgetController> {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // Define responsive scaling factors
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;
    final double scaleFactor = MediaQuery.of(context).textScaleFactor;

    return AnnotatedRegionWidget(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            AssetImageWidget(signupBackgroundImage),
            SafeArea(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: _body(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) => SingleChildScrollView(
    physics: const ClampingScrollPhysics(),
    child: Form(
      key: controller.loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(onTap:(){
                Get.back();
              } ,child: Container(height: 35,width: 35,decoration: BoxDecoration(color: Colors.white.withOpacity(0.2),borderRadius: BorderRadius.circular(35)),child: Icon(Icons.arrow_back_ios,size: 20,).marginOnly(left: 8),)),
              TextView(
                text: "Forgot Your Password?",
                textAlign: TextAlign.start,
                maxLines: 3,
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.LargeTextColor,
                  fontSize: 24,
                  fontFamily: "TOMMYSOFT",
                ),
              ).marginSymmetric(horizontal:10),
            ],
          ).marginOnly(top: margin_14),

          SizedBox(height: Get.height * 0.07), // 3% of screen height
          TextView(
            text: "We’ve got you covered. Enter your registered email to reset your password. We will send an OTP code to your email for the next steps.",
            textAlign: TextAlign.start,
            maxLines: 10,
            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColors.subHeadingColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: "Mulish",
            ),
          ).marginSymmetric(vertical:10),
          _emailField().marginSymmetric(vertical: 12),





          SizedBox(height: Get.height * 0.46),

          _buttons(),
          // Align(
          //   alignment: Alignment.center,
          //   child: _haveAccount(),
          // ).marginSymmetric(vertical: 10)

          // 2% bottom padding
        ],
      ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
    ),
  );






  Widget _emailField() => TextFieldWidget(
    hint: "Enter your email Address",
    tvHeading: "Email Address",
    prefixIcon: Icon(
      Icons.email_outlined,
      color: Colors.white,
    ).marginOnly(left: 10, right: 10),
    textController: controller.emailController ?? TextEditingController(),
    courserColor: AppColors.smallTextColor,
    maxLength: 30,
    focusNode: controller.emailFocusNode,
    // formatter: [EmailTextInputFormatter()],
    inputType: TextInputType.emailAddress,
    validate: (value) => EmailValidator.validateEmail(value?.trim()?? ""),

    borderRadius: Get.width * 0.1, // Relative to screen width
  );
  Widget _buttons() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // 4% of screen width
      Expanded(child: _nextButton()),
    ],
  );

  Widget _nextButton() => Obx(()=>MaterialButtonWidget(
    isloading: controller.isloading.value,
    buttonBgColor: AppColors.LargeTextColor,
    buttonRadius: Get.width * 0.1, // Relative to screen width
    buttonText: "Send OTP Code",
    textColor: AppColors.backgroundColor,
    onPressed: () {

  if (controller.loginFormKey.currentState!.validate()) {

    Map<String, dynamic> requestModel = AuthRequestModel.forgetPasswordRequestModel(
      email: controller.emailController?.text?.trim(),
    );
    if(controller.isloading.value==false){
      controller.handleSubmit(requestModel);
    }


  }

    },
  ));
}


