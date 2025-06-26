import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/data/email_formator.dart'
    show PasswordInputFormatter;
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/validator.dart';
import '../../AuthModule/models/requestmodel/request_models.dart';
import '../controller/changePasswordController.dart';


class Changepassword extends GetView<Changepasswordcontroller> {
  const Changepassword({super.key});

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
      key: controller.signupFormKey,
      child: Obx(()=>Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(35)),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ).marginOnly(left: 8),
                  )),
              Container(
                width: Get.width*0.7,
                child: Center(
                  child: TextView(
                    text: "Change Password",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    textStyle:
                    Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.LargeTextColor,
                      fontSize: 24,
                      fontFamily: "TOMMYSOFT",
                    ),
                  ),
                ),
              ),
            ],
          ).marginOnly(top: margin_14),

          SizedBox(height: Get.height * 0.07), // 3% of screen height
          TextView(
            text:
            "Set a strong new password to secure your account. Make sure it’s unique and easy for you to remember.",
            textAlign: TextAlign.start,
            maxLines: 10,
            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColors.subHeadingColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: "Mulish",
            ),
          ).marginSymmetric(vertical: 10),
          _oldpasswordField().marginOnly(top: 10),
          _passwordField().marginSymmetric(vertical: 20),
          _passwordConfirmField(),

          SizedBox(height: Get.height * 0.2),

          Obx(()=> MaterialButtonWidget(
            isloading: controller.isloading.value,
            buttonBgColor: AppColors.LargeTextColor,
            buttonRadius: Get.width * 0.1, // Relative to screen width
            buttonText: "Update Password",
            textColor: AppColors.backgroundColor,
            onPressed: () {
              if(controller.isloading.value==false){
              if (controller.signupFormKey.currentState!.validate()) {

                Map<String, dynamic> requestModel = AuthRequestModel.PasswordChangeRequestModel(
                  oldPassword: controller.OldPasswordTextController.text,
                    newPassword: controller.ConfirmPasswordTextController.text,


                );
                controller.handleForgetSubmit(requestModel,context);

              }}
            },
          ))

          // 2% bottom padding
        ],
      ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20)),
    ),
  );

  Widget _oldpasswordField() => TextFieldWidget(
    hint: "Old Password",
    tvHeading: "Old Password",
    suffixIcon: IconButton(
        onPressed: () {
          controller.ShowOldPassword.value = !controller.ShowOldPassword.value;
        },
        icon: Obx(() => Icon(
          controller.ShowOldPassword.value
              ? Icons.remove_red_eye_outlined
              : CupertinoIcons.eye_slash,
          color: Colors.white,
        ))),

    prefixIcon: Icon(
      Icons.lock_outlined,
      color: Colors.white,
    ).marginOnly(left: 10, right: 10),
    textController: controller.OldPasswordTextController,
    courserColor: AppColors.smallTextColor,
    maxLength: 30,
    obscureText: controller.ShowOldPassword.value,
    focusNode: controller.OldPasswordFocusNode,
    inputType: TextInputType.text,
    // formatter: [PasswordInputFormatter()],
    validate: (value) =>
        PasswordFormValidator.validatePassword(value?.trim() ?? ""),
    borderRadius: Get.width * 0.1, // Relative to screen width
  );

  Widget _passwordField() => TextFieldWidget(
    hint: "Password",
    tvHeading: "Password",
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
    inputType: TextInputType.text,
    // formatter: [PasswordInputFormatter()],
    validate: (value) =>
        PasswordFormValidator.validatePassword(value?.trim() ?? ""),
    borderRadius: Get.width * 0.1, // Relative to screen width
  );

  Widget _passwordConfirmField() => TextFieldWidget(
    hint: "Confirm Password",
    tvHeading: "Confirm Password",
    suffixIcon: IconButton(
        onPressed: () {
          controller.ShowConfirmPassword.value =
          !controller.ShowConfirmPassword.value;
        },
        icon: Obx(() => Icon(
          controller.ShowConfirmPassword.value
              ? Icons.remove_red_eye_outlined
              : CupertinoIcons.eye_slash,
          color: Colors.white,
        ))),

    prefixIcon: Icon(
      Icons.lock_outlined,
      color: Colors.white,
    ).marginOnly(left: 10, right: 10),
    textController: controller.ConfirmPasswordTextController,
    courserColor: AppColors.smallTextColor,
    maxLength: 30,
    obscureText: controller.ShowConfirmPassword.value,
    focusNode: controller.ConfirmPasswordFocusNode,
    inputType: TextInputType.text,
    // formatter: [PasswordInputFormatter()],
    validate: (value) => PasswordFormValidator.validateConfirmPasswordMatch(
        value: value?.trim() ?? "",
        password: controller.PasswordTextController.text),

    borderRadius: Get.width * 0.1, // Relative to screen width
  );


}
