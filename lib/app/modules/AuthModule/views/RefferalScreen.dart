import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../../../core/widget/validator.dart';

class Refferalscreen extends GetView<ReferalController> {
  const Refferalscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define responsive scaling factors
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;
    final double scaleFactor = MediaQuery.of(context).textScaleFactor;



    return AnnotatedRegionWidget(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.blackColor,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) => SingleChildScrollView(
    physics: const ClampingScrollPhysics(),
    child: Container(
      // Use full height minus safe area for responsiveness
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05), // 5% of screen width
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.2), // 8% of screen height
          _image(),
          TextView(
            text: "Enter your referral code and get extra reward points.",
            textAlign: TextAlign.center,
            maxLines: 3,
            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColors.LargeTextColor,
              fontSize:24,
              fontFamily: "TOMMYSOFT",

            ),
          ),
          SizedBox(height: Get.height * 0.05), // 3% of screen height
          _refferalCodeField(),
          const Spacer(), // Pushes buttons to bottom
          _buttons(),
          SizedBox(height: Get.height * 0.02), // 2% bottom padding
        ],
      ),
    ),
  );

  Widget _refferalCodeField() => TextFieldWidget(
    hint: "Enter Referral Code",
    tvHeading: "Enter Referral Code",

    textController: controller.refferalCodeController ?? TextEditingController(),
    courserColor: AppColors.smallTextColor,
    maxLength: 30,
    focusNode: controller.RefferalCodeFocusNode,
    inputType: TextInputType.text,

    borderRadius: Get.width * 0.1, // Relative to screen width


  );

  Widget _image() => ClipRRect(
    borderRadius: BorderRadius.circular(Get.width * 0.025), // 2.5% of screen width
    child: FractionallySizedBox(
      widthFactor: 0.75, // 75% of available width
      child: AssetImageWidget(
        refferalImage,
        imageHeight: Get.height * 0.25, // 25% of screen height
        imageFitType: BoxFit.contain,
      ),
    ),
  );

  Widget _buttons() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(child: _prevButton()),
      SizedBox(width: Get.width * 0.04), // 4% of screen width
      Expanded(child: _nextButton()),
    ],
  );

  Widget _prevButton() => MaterialButtonWidget(
    buttonBgColor: Colors.white,
    isOutlined: false,
    borderColor: AppColors.appDarkColor,
    borderWidth: 2,
    buttonText: "Skip",
    textColor: AppColors.backgroundColor,
    buttonRadius: Get.width * 0.1, // Relative to screen width
    onPressed: controller.skipPage,
  );

  Widget _nextButton() => MaterialButtonWidget(
    buttonBgColor: AppColors.LargeTextColor,
    buttonRadius: Get.width * 0.1, // Relative to screen width
    buttonText: "Submit",
    textColor: AppColors.backgroundColor,
    onPressed:(){
      Get.offAllNamed(AppRoutes.signUpRoute,arguments: {"Referral":controller.refferalCodeController?.text});
    },
  );
}