import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/core/widget/validator.dart';

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

class SignupScreen extends GetView<SignUpController> {
  const SignupScreen({super.key});

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
              TextView(
                text: "Sign Up & Start Collecting Stamps",
                textAlign: TextAlign.start,
                maxLines: 3,
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.LargeTextColor,
                      fontSize: 24,
                      fontFamily: "TOMMYSOFT",
                    ),
              ),
              SizedBox(height: Get.height * 0.05), // 3% of screen height
              _refferalCodeField(),
              _emailField().marginSymmetric(vertical: 12),
              CountryPickerTextField(
                controller: controller.mobileNumberTextController!,
                focusNode: controller.mobileNumberFocusNode!,
                hintText: 'Phone Number',
                labelText: "Phone Number ",
                showBorder: true,
                showCountryFlag: true,
                textInputAction: TextInputAction.done,
                inputTextStyle: textStyleTitleMedium().copyWith(
                    color: AppColors.whiteColor,
                    fontFamily: "Mulish",
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
                selectedCountry: controller.selectedCountry,
                onCountryChanged: (value) {
                  controller.selectedCountry.value = value;
                },
              ),

              TextView(
                text: "Gender",
                textStyle: const TextStyle(
                    color: AppColors.whiteColor,
                    fontFamily: "TOMMYSOFT",
                    fontSize: 14,
                    fontWeight: FontWeight.w800),
                maxLines: 4,
              ).marginSymmetric(vertical: margin_10),
              Obx(() => Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(24, 34, 38, 1),
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: AssetImageWidget(
                              gendericon,
                              imageHeight: 20,
                            )),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(

                              isExpanded: true,
                              hint: Text(
                                "Select",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Mulish",
                                  color: AppColors.smallTextColor,
                                ),
                              ),

                              items: controller.genders
                                  .map((String country) =>
                                      DropdownMenuItem<String>(
                                        value: country,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                country,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              value: controller.selectGender.value.isEmpty
                                  ? null
                                  : controller.selectGender.value,
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  border: Border.all(
                                      color: Color.fromRGBO(24, 34, 38, 1)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (String? value) {
                                if (value != null) {
                                  controller.selectGender.value = value;
                                }
                              },
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ),
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(24, 34, 38, 1),
                                    borderRadius: BorderRadius.circular(50)),
                                padding: EdgeInsets.only(right: 16),
                                height: 49,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              _passwordField().marginSymmetric(vertical: 10),
              _passwordConfirmField(),
              Obx(
                () => Row(
                  children: [
                    controller.Acceptterms.value == true
                        ? GestureDetector(
                            onTap: () {
                              controller.Acceptterms.value = false;
                            },
                            child: Icon(
                              Icons.check_box,
                              color: Colors.yellow,
                            ))
                        : GestureDetector(
                            onTap: () {
                              controller.Acceptterms.value = true;
                            },
                            child: Icon(
                              Icons.check_box_outline_blank_rounded,
                              color: Colors.yellow,
                            )),
                    _termOfUse(),
                  ],
                ).marginSymmetric(vertical: 20),
              ),
              _buttons(),
              Align(
                alignment: Alignment.center,
                child: _haveAccount(),
              ).marginSymmetric(vertical: 10)
            ],
          ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20)),
        ),
      );

  Widget _termOfUse() => Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "I agree to Loyalty ",
          style: textStyleBodyLarge().copyWith(
            color: AppColors.whiteColor,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: "Mulish",
          ),
          children: [
            TextSpan(
              text: "Terms & Conditions.",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint("helllo>>>>>>>>>>>>>>");
                  Get.back();
                },
              style: textStyleBodyLarge().copyWith(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid, // Optional: ensures a solid line
                decorationThickness: 1.5, // Adjust thickness for visibility
                decorationColor: Colors.yellow, // Match or customize underline color
                fontSize: 13,
                color: Colors.yellow,
                fontWeight: FontWeight.w900,
                fontFamily: "Mulish",
                height: 1.5, // Increases vertical spacing, pushing underline further from text
              ),
            ),
          ],
        ),
      );

  Widget _haveAccount() => Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Already have an account?",
          style: textStyleBodyLarge().copyWith(
            color: AppColors.whiteColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: "Mulish",
          ),
          children: [
            TextSpan(
              text: " Sign In",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  debugPrint("helllo>>>>>>>>>>>>>>");
                  Get.toNamed(AppRoutes.LoginRoute);
                },
              style: textStyleBodyLarge().copyWith(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid, // Optional: ensures a solid line
                decorationThickness: 1.5, // Adjust thickness for visibility
                decorationColor: Colors.yellow, // Match or customize underline color
                fontSize: 13,
                color: Colors.yellow,
                fontWeight: FontWeight.w900,
                fontFamily: "Mulish",
                height: 1.5, // Increases vertical spacing, pushing underline further from text
              ),
            ),
          ],
        ),
      );

  Widget _refferalCodeField() => TextFieldWidget(
        hint: "Enter Your Full Name",
        tvHeading: "Full Name",
        prefixIcon: Icon(
          Icons.person_outline_rounded,
          color: Colors.white,
        ).marginOnly(left: 10, right: 10),
        textController:
            controller.refferalCodeController ?? TextEditingController(),
        courserColor: AppColors.smallTextColor,
        maxLength: 30,
        focusNode: controller.RefferalCodeFocusNode,
        inputType: TextInputType.text,
        borderRadius: Get.width * 0.1,
        formatter: [NameTextInputFormatter()],
        validate: (value) => NameValidator.validateName(
          title: "Full name",
          value: value?.trim() ?? '',
        ),
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
        // formatter: [PasswordInputFormatter()],
        validate: (value) =>
            PasswordFormValidator.validatePassword(value?.trim() ?? ""),

        obscureText: controller.ShowPassword.value,
        focusNode: controller.PasswordFocusNode,
        inputType: TextInputType.text,

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
    // formatter: [PasswordInputFormatter()],
    validate: (value) =>
        PasswordFormValidator.validateConfirmPasswordMatch(value:value?.trim() ?? "",password: controller.PasswordTextController.text),
        textController: controller.ConfirmPasswordTextController,
        courserColor: AppColors.smallTextColor,
        maxLength: 30,
        obscureText: controller.ShowConfirmPassword.value,
        focusNode: controller.ConfirmPasswordFocusNode,
        inputType: TextInputType.text,

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
        // formatter: [EmailTextInputFormatter()],
        inputType: TextInputType.emailAddress,
        validate: (value) => EmailValidator.validateEmail(value?.trim() ?? ""),
        borderRadius: Get.width * 0.1, // Relative to screen width
      );

  Widget _buttons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _nextButton()),
        ],
      );

  Widget _nextButton() => Obx(()=>MaterialButtonWidget(
        isloading: controller.isloading.value,
        buttonBgColor: AppColors.LargeTextColor,
        buttonRadius: Get.width * 0.1, // Relative to screen width
        buttonText: "Sign Up",
        textColor: AppColors.backgroundColor,
        onPressed: () {


          if (controller.signupFormKey.currentState!.validate()) {
            if(controller.Acceptterms.value==false){
              Get.snackbar('Error', 'Please Accept terms & Conditions');
              controller.isloading.value=false;
              controller.isloading.refresh();
              return ;
            }
            if( controller.isloading.value==false){
              controller.isloading.value=true;
              controller.isloading.refresh();
              Map<String, dynamic> requestModel = AuthRequestModel.SignupRequestModel(
                  fullName: controller.refferalCodeController?.text?.trim(),
                  email: controller.emailController?.text?.trim(),
                  countryCode: "+${controller.selectedCountry.value.dialCode}",
                  phoneNumber: controller.mobileNumberTextController.text,
                  gender: controller.selectGender.value,
                  password: controller.ConfirmPasswordTextController.text,

                  fcmToken: ""

              );
              controller.handleSubmit(requestModel);
            }

          }
        },
      ));
}
