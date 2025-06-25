import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../controller/notification_controller.dart';


class Notifications extends GetView<NotificationController> {
  const Notifications({super.key});


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

  Widget _body(BuildContext context) => Column(
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
              )).marginSymmetric(horizontal: 20),
          Container(
            width: Get.width*0.6,
            child: Center(
              child: TextView(
                text: "Notifications",
                textAlign: TextAlign.start,
                maxLines: 3,
                textStyle:
                Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.LargeTextColor,
                  fontSize: 24,
                  fontFamily: "TOMMYSOFT",
                ),
              ).marginSymmetric(horizontal: 10),
            ),
          ),
        ],
      ).marginOnly(top: margin_14),
      Container(
        height: Get.height*0.8,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(top: 20),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return _buildNotificationItem(context, index);
                },
              ),

            ],
          ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
        ),
      ).marginOnly(top: margin_40),
    ],
  );


  Widget _buildNotificationItem(BuildContext context, int index) => Container(
    height: height_105,
    width: Get.width*0.9,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),image: DecorationImage(image:index==0||index==1?AssetImage(blackBack) :AssetImage(whiteBack),fit: BoxFit.cover)),
    margin:  EdgeInsets.symmetric( vertical: 5,),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        index==1||index==0? Container(height: height_105,width:10,decoration: BoxDecoration(color:AppColors.LargeTextColor,borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft:  Radius.circular(8),
          // Radius on top-left corner only
          // Radius on top-left corner only
        ),),):SizedBox(width:10,),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width*0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                  text: "Charlotte Joined Today",
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  textStyle:
                  Theme.of(context).textTheme.displayMedium!.copyWith(
                    color:index==0||index==1?AppColors.blackColor :AppColors.whiteColor,
                    fontSize: 14,
                    fontFamily: "TOMMYSOFT",
                  ),
                ),
                TextView(
                  text: "5 min ago",
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  textStyle:
                  Theme.of(context).textTheme.displayMedium!.copyWith(
                    color:index==0||index==1?AppColors.blackColor :AppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Mulish",
                  ),
                ).marginSymmetric(horizontal: 10),
              ],
            ),
          ),
          SizedBox(
            width: Get.width*0.75,
            child: TextView(
              text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              textAlign: TextAlign.start,
              maxLines: 5,
              textStyle:
              Theme.of(context).textTheme.displayMedium!.copyWith(
                color:index==0||index==1?AppColors.blackColor :AppColors.whiteColor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: "Mulish",
              ),
            ).marginSymmetric(vertical: 10),
          ),
        ],
      ).marginSymmetric(horizontal: 20),
    ],)
  );
}