import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/export.dart';
import '../../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../../core/widget/validator.dart';
import '../../../../data/email_formator.dart';
import '../controller/dart/profile_controller.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive scaling factors
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
            const AssetImageWidget(signupBackgroundImage),
            SafeArea(
              child: SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: _buildBody(context, screenWidth, screenHeight, scaleFactor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      double screenWidth,
      double screenHeight,
      double scaleFactor,
      ) {
    return Column(
      children: [
        _buildHeader(context, screenWidth),
        _buildContent(context, screenWidth, screenHeight),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            height: screenWidth * 0.09, // 9% of screen width
            width: screenWidth * 0.09,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle, // Simplified to use shape
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ).marginOnly(left: 8),
          ),
        ),
       // Responsive spacing
        SizedBox(
          width: Get.width*0.7,
          child: Expanded(
            child: TextView(
              text: "Profile",
              textAlign: TextAlign.center,
              maxLines: 3,
              textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: AppColors.LargeTextColor,
                fontSize: 24 * MediaQuery.of(context).textScaleFactor,
                fontFamily: "TOMMYSOFT",
              ),
            ),
          ),
        ),
      ],
    ).marginOnly(top: margin_14, left: margin_20, right: margin_20);
  }

  Widget _buildContent(BuildContext context, double screenWidth, double screenHeight) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child:( Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ SizedBox(height: screenHeight * 0.06),
            AssetImageWidget(
              offerCoverImage,
              imageHeight: screenWidth * 0.4, // 40% of screen width
              imageWidth: screenWidth * 0.4,
              radiusAll: screenWidth * 0.4, // Circular image
              imageFitType: BoxFit.cover,
            ),
            SizedBox(height: screenHeight * 0.02), // 3% of screen height
            _buildReferralCodeField(screenWidth),
            _buildEmailField(screenWidth).marginSymmetric(vertical: screenHeight *0.02),
            CountryPickerTextField(
              controller: controller.mobileNumberTextController!,
              focusNode: controller.mobileNumberFocusNode!,
              hintText: 'Phone Number',
              labelText: "Phone Number ",
              readOnly: true,
              borderColor: AppColors.backgroundColor,
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
            _buildGenderField(screenWidth).marginSymmetric(vertical: screenHeight *0.02),
            _buttons().marginSymmetric(vertical: 20)

          ],
        ).marginOnly(top: margin_10, left: margin_20, right: margin_20)),
      ),
    );
  }

  Widget _buildReferralCodeField(double screenWidth) {
    return TextFieldWidget(
      hint: "Enter Your Full Name",
      tvHeading: "Full Name",
      prefixIcon: const Icon(
        Icons.person_outline_rounded,
        color: Colors.white,
      ).marginOnly(left: 10, right: 10),
      readOnly: true,
      showBorder: true,
      textController: controller.referralCodeController,
      courserColor: AppColors.smallTextColor,
      maxLength: 30,
      focusNode: controller.referralCodeFocusNode,
      inputType: TextInputType.text,
      borderRadius: screenWidth * 0.1, // Responsive border radius
      borderColor: AppColors.backgroundColor,
      formatter: [NameTextInputFormatter()],
      validate: (value) => NameValidator.validateName(
        title: "Full name",
        value: value?.trim() ?? '',
      ),
    );
  }

  Widget _buildGenderField(double screenWidth) {
    return TextFieldWidget(
      hint: "Gender",
      tvHeading: "Gender",
      prefixIcon:AssetImageWidget(
        gendericon,
        imageHeight: 20,
      ).marginOnly(left:12, right: 10),
      textController: controller.genderController ?? TextEditingController(),
      courserColor: AppColors.smallTextColor,
      maxLength: 30,
      readOnly: true,
      borderColor: AppColors.backgroundColor,
      focusNode: controller.genderFocusNode,
      inputType: TextInputType.emailAddress,

      borderRadius: screenWidth * 0.1, // Responsive border radius
    );
  }

  Widget _buildEmailField(double screenWidth) {
    return TextFieldWidget(
      hint: "Enter your email Address",
      tvHeading: "Email Address",
      prefixIcon: const Icon(
        Icons.email_outlined,
        color: Colors.white,
      ).marginOnly(left: 10, right: 10),
      textController: controller.emailController ?? TextEditingController(),
      courserColor: AppColors.smallTextColor,
      maxLength: 30,
      readOnly: true,
      borderColor: AppColors.backgroundColor,
      focusNode: controller.emailFocusNode,
      inputType: TextInputType.emailAddress,
      validate: (value) => EmailValidator.validateEmail(value?.trim() ?? ""),
      borderRadius: screenWidth * 0.1, // Responsive border radius
    );
  }

  Widget _buttons() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(child: _deleteButton()),
      SizedBox(width: 10,),
      Expanded(child: _nextButton()),
    ],
  );

  Widget _nextButton() => MaterialButtonWidget(

    buttonBgColor: AppColors.LargeTextColor,
    buttonRadius: Get.width * 0.1, // Relative to screen width
    buttonText: "Edit",
    buttonTextStyle: TextStyle(color: Colors.black),
    textColor: AppColors.backgroundColor,
    onPressed: () {


    },
  );

  Widget _deleteButton() => MaterialButtonWidget(

    buttonBgColor: AppColors.redColor,
    buttonRadius: Get.width * 0.1, // Relative to screen width
    buttonText: "Delete Account",
    buttonTextStyle: TextStyle(color: Colors.white),
    textColor: AppColors.backgroundColor,
    onPressed: () {


    },
  );


}