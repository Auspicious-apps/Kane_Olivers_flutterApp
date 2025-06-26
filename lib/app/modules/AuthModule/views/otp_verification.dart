import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import 'package:pinput/pinput.dart';


import '../../../core/widget/validator.dart';
import '../controllers/otp_verification_controller.dart';
import '../models/requestmodel/request_models.dart';

class OtpVerification extends GetView<OtpVerificationController> {
  const OtpVerification({super.key});

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
              text: "Verify Your OTP",
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
          text: "Please check your email inbox for a message from Loyalty. Enter the on-time verfication code below.",
          textAlign: TextAlign.start,
          maxLines: 10,
          textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: AppColors.subHeadingColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontFamily: "Mulish",
          ),
        ).marginSymmetric(vertical:10),

        _pinPutWidget().marginOnly(top:10),

        Obx(() {
          return Center(
            child: GestureDetector(
                onTap: () {
                  if(controller.timerSeconds.value==0) {

                    Map<String, dynamic> requestModel = AuthRequestModel
                        .forgetPasswordRequestModel(
                        email: controller.email
                    );
                    if (controller.isresend.value == false){
                      controller.isresend.value=true;
                      controller.isresend.refresh();
                      controller.ResendOtpApi(requestModel);
                  }else{
                      print("having request");
                    }
                  }
                },
                child: Text(
                  controller.timerSeconds.value > 0
                      ? "You can resend the code in ${(controller.timerSeconds.value).toString()} seconds"
                      : "Resend OTP",

                  style:  TextStyle(
                    fontSize: 12,
                    color:   controller.timerSeconds.value > 0?AppColors.subHeadingColor:Colors.yellow,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Mulish",
                  ),
                )),
          );
        }).marginOnly(bottom: 10,top: 20),


        SizedBox(height: Get.height * 0.46),

        _buttons(),
        // Align(
        //   alignment: Alignment.center,
        //   child: _haveAccount(),
        // ).marginSymmetric(vertical: 10)

        // 2% bottom padding
      ],
    ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
  );



  Widget _pinPutWidget() {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: textStyleTitleSmall()!.copyWith(fontSize: 22,color: AppColors.whiteColor,fontFamily: "Mulish"),
      decoration: BoxDecoration(
          color:  AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(50),

          border:  Border.all(color:AppColors.textfieldBorderColor)
      ),
    );

    return Form(
        key: controller.formKey,
        child: Pinput(
          length: 6,
          controller: controller.otpController,
          focusNode: controller.pinFocusNode,
          // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
          // listenForMultipleSmsOnAndroid: true,
          defaultPinTheme: defaultPinTheme,
          errorTextStyle: textStyleTitleSmall()!.copyWith(fontSize: 12,color: Colors.red,fontFamily: "Mulish"),

          forceErrorState: controller.forceErrorState.value,
          separatorBuilder: (index) => SizedBox(width: 10),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            final data = FieldChecker.otpValidator(value: value);
            if (data != null) {
              controller.forceErrorState.value = true;
            }
            return data;
          },
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: (pin) {
            debugPrint('onCompleted: $pin');
          },
          onChanged: (value) {
            controller.forceErrorState.value = false;
            debugPrint('onChanged: $value');
          },
          cursor: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 1,
                    height: 30,
                    color:AppColors.textfieldBorderColor),
              ]),

          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: Colors.yellow),
            ),
          ),



          // :  defaultPinTheme.copyWith(
          //   decoration: defaultPinTheme.decoration!.copyWith(
          //     border: Border.all(color: AppColors.textfieldBorderColor),
          //   ),
          // ),
          disabledPinTheme:defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color:AppColors.textfieldBorderColor),
              )) ,
          submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color:AppColors.textfieldBorderColor),
              )),
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(color: AppColors.redColor.withOpacity(0.8)),
          ),
        ));

  }



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
    buttonText: "Submit",
    textColor: AppColors.backgroundColor,
    onPressed: () {
      if (controller.isloading.value == false) {
        controller.isloading.value = true;
        controller.isloading.refresh();
        if (controller.formKey.currentState!.validate()) {
          Map<String, dynamic> requestModel = AuthRequestModel
              .verifyOtpRequestModel(
              otp: controller.otpController.text
          );
          // debugPrint("controller.otpController.text>>>>>>>>>>>${controller.otpController.text}");

          if (Get?.previousRoute == AppRoutes.signUpRoute ||
              Get.previousRoute == AppRoutes.LoginRoute) {
            controller.handleSubmit(requestModel);
          } else {
            controller.handleForgetSubmit(requestModel);
          }
        } else {
          controller.isloading.value = false;
          controller.isloading.refresh();
        }
      }
    }
      // Get.toNamed(AppRoutes.confirmPasswordRoute);

  ));
}


