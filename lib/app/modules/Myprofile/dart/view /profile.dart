import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/export.dart';
import '../../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../../core/widget/validator.dart';
import '../../../../data/email_formator.dart';
import '../controller/dart/profile_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            height: screenWidth * 0.09,
            width: screenWidth * 0.09,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ).marginOnly(left: 8),
          ),
        ),
        Container(
          width: Get.width * 0.7,
          child: Center(
            child: Skeleton.replace(
              replacement: Container(
                height: 24 * MediaQuery.of(context).textScaleFactor,
                width: Get.width * 0.4,
                color: Colors.grey[900],
              ),
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
        ),
      ],
    ).marginOnly(top: margin_14, left: margin_20, right: margin_20);
  }

  Widget _buildContent(BuildContext context, double screenWidth, double screenHeight) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Obx(() => Skeletonizer(
          enabled: controller.isLoading.value,
          effect: ShimmerEffect(
            baseColor: Colors.grey[900]!,
            highlightColor: Colors.grey[800]!,
            duration: Duration(seconds: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.06),
              Skeleton.replace(
                replacement: Container(
                  height: screenWidth * 0.4,
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    shape: BoxShape.circle,
                  ),
                ),
                child: AssetImageWidget(
                  offerCoverImage,
                  imageHeight: screenWidth * 0.4,
                  imageWidth: screenWidth * 0.4,
                  radiusAll: screenWidth * 0.4,
                  imageFitType: BoxFit.cover,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Skeleton.replace(
                replacement: Container(
                  height: 50,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                  ),
                ),
                child: _buildReferralCodeField(screenWidth),
              ),
              Skeleton.replace(
                replacement: Container(
                  height: 50,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                  ),
                ),
                child: _buildEmailField(screenWidth),
              ).marginSymmetric(vertical: screenHeight * 0.02),
              Skeleton.replace(
                replacement: Container(
                  height: 50,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                  ),
                ),
                child: CountryPickerTextField(
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
              ),
              Skeleton.replace(
                replacement: Container(
                  height: 50,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                  ),
                ),
                child: _buildGenderField(screenWidth),
              ).marginSymmetric(vertical: screenHeight * 0.02),
              Skeleton.replace(
                replacement: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(Get.width * 0.1),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(Get.width * 0.1),
                        ),
                      ),
                    ),
                  ],
                ),
                child: _buttons(),
              ).marginSymmetric(vertical: 20),
            ],
          ).marginOnly(top: margin_10, left: margin_20, right: margin_20),
        )),
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
      borderRadius: screenWidth * 0.1,
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
      prefixIcon: AssetImageWidget(
        gendericon,
        imageHeight: 20,
      ).marginOnly(left: 12, right: 10),
      textController: controller.genderController ?? TextEditingController(),
      courserColor: AppColors.smallTextColor,
      maxLength: 30,
      readOnly: true,
      borderColor: AppColors.backgroundColor,
      focusNode: controller.genderFocusNode,
      inputType: TextInputType.emailAddress,
      borderRadius: screenWidth * 0.1,
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
      borderRadius: screenWidth * 0.1,
    );
  }

  Widget _buttons() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(child: _deleteButton()),
      SizedBox(width: 10),
      Expanded(child: _nextButton()),
    ],
  );

  Widget _nextButton() => MaterialButtonWidget(
    buttonBgColor: AppColors.LargeTextColor,
    buttonRadius: Get.width * 0.1,
    buttonText: "Edit",
    buttonTextStyle: TextStyle(color: Colors.black),
    textColor: AppColors.backgroundColor,
    onPressed: () {},
  );

  Widget _deleteButton() => MaterialButtonWidget(
    buttonBgColor: AppColors.redColor,
    buttonRadius: Get.width * 0.1,
    buttonText: "Delete Account",
    buttonTextStyle: TextStyle(color: Colors.white),
    textColor: AppColors.backgroundColor,
    onPressed: () {},
  );
}