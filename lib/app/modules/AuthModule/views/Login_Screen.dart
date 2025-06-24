import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/core/widget/validator.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/login_Controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../data/email_formator.dart'
    show NameTextInputFormatter, PasswordInputFormatter;
import '../models/requestmodel/request_models.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
              TextView(
                text: "Welcome Back!",
                textAlign: TextAlign.start,
                maxLines: 3,
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.LargeTextColor,
                      fontSize: 24,
                      fontFamily: "TOMMYSOFT",
                    ),
              ).marginOnly(top: margin_14),
              SizedBox(height: Get.height * 0.07), // 3% of screen height

              _emailField().marginSymmetric(vertical: 12),
              _termOfUse(),
              _passwordField().marginSymmetric(vertical: 10),

              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.forgetRoute);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: TextView(
                      text: "Forget Password?",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 15,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w900)),
                ).marginSymmetric(vertical: 10),
              ),

              SizedBox(height: Get.height * 0.39),

              _buttons(),
              Align(
                alignment: Alignment.center,
                child: _haveAccount(),
              ).marginSymmetric(vertical: 10)

              // 2% bottom padding
            ],
          ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
        ),
      );

  _termOfUse() => Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Password",
          style: textStyleTitleMedium().copyWith(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontFamily: "TOMMYSOFT",
          ),
          children: [
            TextSpan(
              text: "  (Minimum 8 Characters)",
              recognizer: TapGestureRecognizer()..onTap = () {},
              style: textStyleBodyLarge().copyWith(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                fontFamily: "Mulish",
              ),
            ),
          ],
        ),
      );
  _haveAccount() => Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Don't have an account?",
          style: textStyleBodyLarge().copyWith(
            color: AppColors.whiteColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: "Mulish",
          ),
          children: [
            TextSpan(
              text: " Sign Up",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint("helllo>>>>>>>>>>>>>>");
           Get.offAllNamed(AppRoutes.refferalScreen);
                },
              style: textStyleBodyLarge().copyWith(
                color: AppColors.whiteColor,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                fontFamily: "Mulish",
              ),
            ),
          ],
        ),
      );

  Widget _passwordField() => TextFieldWidget(
        hint: "Password",
        // tvHeading: "Password",
        suffixIcon: IconButton(
            onPressed: () {
              controller.ShowPassword.value = !controller.ShowPassword.value;
            },
            icon: Obx(() => Icon(
                  controller.ShowPassword.value
                      ? Icons.remove_red_eye_outlined
                      : CupertinoIcons.eye_slash,
                  color: Colors.white,
                ))),

        prefixIcon: Icon(
          Icons.lock_outlined,
          color: Colors.white,
        ).marginOnly(left: 10, right: 10),
        textController: controller.PasswordTextController,
        courserColor: AppColors.smallTextColor,
        maxLength: 30,
        obscureText: controller.ShowPassword.value,
        focusNode: controller.PasswordFocusNode,
       formatter: [PasswordInputFormatter()],
       validate: (value) =>
        PasswordFormValidator.validatePassword(value?.trim() ?? ""),



    borderRadius: Get.width * 0.1, // Relative to screen width
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
    formatter: [EmailTextInputFormatter()],
    inputType: TextInputType.emailAddress,
    validate: (value) => EmailValidator.validateEmail(value?.trim() ?? ""),

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
        buttonText: "Sign In",
        textColor: AppColors.backgroundColor,
        onPressed: () {
          controller.isloading.value=true;
          controller.isloading.refresh();
          if (controller.loginFormKey.currentState!.validate()) {


            Map<String, dynamic> requestModel = AuthRequestModel.loginRequestModel(

                email: controller.emailController?.text?.trim(),
                password: controller.PasswordTextController.text,
                fcmToken: ""
            );
            controller.handleSubmit(requestModel);
          }else{
            controller.isloading.value=false;
            controller.isloading.refresh();
          }

        },
      ));
}
