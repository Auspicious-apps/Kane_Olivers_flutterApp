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
import '../controllers/setting_screen_controller.dart';

class SettingScreen extends GetView<SettingScreenController> {
  const SettingScreen({super.key});

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


  Widget _buildOtpModalContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,

      height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,


        borderRadius: BorderRadius.circular(16.0),


      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          TextView(
            textAlign:TextAlign.center,
            text: "Log Out?",
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "TOMMYSOFT",
                fontSize: 24,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10),
          TextView(
            textAlign:TextAlign.center,
            text: "Are you sure you want to log out from your account?",
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "Mulish",
                fontSize: 16,
                fontWeight: FontWeight.w500),
            maxLines: 4,
          ).marginSymmetric(horizontal: margin_20,vertical: margin_10),
          SizedBox(height: 20.0),

          Row(
            children: [
              Expanded(
                child: MaterialButtonWidget(
                  buttonBgColor: AppColors.whiteColor,
                  isOutlined: true,
                  borderColor: Colors.black,
                  buttonRadius: Get.width * 0.1, // Relative to screen width
                  buttonText: "Cancel",
                  textColor: AppColors.backgroundColor,
                  onPressed:(){
                    Get.back();
                  },
                ),
              ),

              SizedBox(width: 10,),

              Expanded(
                child: MaterialButtonWidget(
                  buttonBgColor: AppColors.LargeTextColor,
                  buttonRadius: Get.width * 0.1, // Relative to screen width
                  buttonText: "Logout",
                  textColor: AppColors.backgroundColor,
                  onPressed:(){
                    controller.handleSubmit();
                   // controller.localStorage.clearLoginData();
                   //
                   //  Get.offAllNamed(AppRoutes.signUpRoute);
                  },
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 20)



        ],
      ),
    );
  }

  Widget _listitem(BuildContext context,icon,name) => GestureDetector(
    onTap: (){
      debugPrint(">>>>>>$name");
      if(name=="Logout"){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              child: _buildOtpModalContent(context),
            );
          },
        );
      }
      if(name=="Change Password"){
        Get.toNamed(AppRoutes.changePassword);
      }
      if(name=="Privacy Policy"||name=="Terms & Conditions"||name=="Help & Support"){
      Get.toNamed(AppRoutes.StaticPage,arguments: {"otp":name});
      }
      if(name=="Top Leaders Privacy"){
        Get.toNamed(AppRoutes.TopLeadersSettingRoute);
      }
      if(name=="Notifications"){
        Get.toNamed(AppRoutes.NotificationRoute);
      }
      if(name=="My Profile"){
        Get.toNamed(AppRoutes.Profile);
      }
    },
    child: Container(
      height: 40,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AssetImageWidget(icon,imageFitType: BoxFit.contain,imageWidth: 30,imageHeight: 20,),
          SizedBox(width: Get.width*0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                        text: name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 14,

                          fontFamily: "TOMMYSOFT",
                        )).marginSymmetric(horizontal:10),

                  ],
                ),
                Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15)
              ],
            ),
          ),

        ],
      ).marginOnly(left: 10,right: 10),
    ),
  );

  Widget _body(BuildContext context) => SingleChildScrollView(
    physics: const ClampingScrollPhysics(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: TextView(
            text: "Settings",
            textAlign: TextAlign.center,
            maxLines: 1,
            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColors.LargeTextColor,
              fontSize: 24,
              fontFamily: "TOMMYSOFT",
            )).marginSymmetric(vertical:10),
        ),
        SizedBox(height: Get.height*0.07,),
        Container(height:100,width: Get.width,decoration: BoxDecoration(color: AppColors.LargeTextColor,borderRadius: BorderRadius.circular(8)),child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AssetImageWidget(coinsicon,imageHeight:50,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                          text: "Total Points",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Mulish",
                          )).marginSymmetric(horizontal:10),
                      TextView(
                          text: "150",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "TOMMYSOFT",
                          )).marginSymmetric(horizontal:10,vertical: 10),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),

          ],
        ).paddingSymmetric(horizontal: margin_20),),
        Container(decoration: BoxDecoration(color: Color.fromRGBO(24, 34, 38, 1),borderRadius: BorderRadius.circular(8)),child: Column(
          children: [
            _listitem(Get.context!,iconMyProfile,"My Profile"),
            _listitem(Get.context!,iconCoupon,"All New Coupons"),
            _listitem(Get.context!,iconNotification,"Notifications"),
            _listitem(Get.context!,iconLeader,"Top Leaders Privacy"),
            _listitem(Get.context!,iconHelp,"Help & Support"),

            _listitem(Get.context!,iconHelp,"Terms & Conditions"),
            _listitem(Get.context!,iconPrivacy,"Privacy Policy"),
            _listitem(Get.context!,iconPrivacy,"Change Password"),
            _listitem(Get.context!,iconLogOut,"Logout").paddingOnly(bottom: 30),
          ],
        )).marginSymmetric(vertical: 20)




      ],
    ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
  );







}


