import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/core/widget/network_image_widget.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/bindings/home_screen_binding.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/validator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Skeleton.replace(
              replacement: Container(
                width: screenWidth,
                height: screenHeight,
                color: Colors.grey[900], // Placeholder for background image
              ),
              child: AssetImageWidget(signupBackgroundImage),
            ),
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
    child:Obx(()=> Skeletonizer(
      enabled: controller.isLoading.value,
      effect: ShimmerEffect(
        baseColor: Colors.grey[900]!, // Dark base for dark mode
        highlightColor: Colors.grey[700]!, // Subtle highlight
        duration: Duration(seconds: 1),
      ),
      textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextView(
                text: controller.isLoading.value
                    ? "Hi, Loading..."
                    : "Hi, ${controller.userResponseModel?.value.data?.userName ?? ""}!",
                textAlign: TextAlign.center,
                maxLines: 1,
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.LargeTextColor,
                  fontSize: 22,
                  fontFamily: "TOMMYSOFT",
                ),
              ).marginSymmetric(vertical: 10),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Skeleton.replace(
                    replacement: Container(
                      height: 25,
                      width: 25,
                      color: Colors.grey[800],
                    ),
                    child: AssetImageWidget(
                      iconNotification,
                      imageHeight: 25,
                      imageFitType: BoxFit.contain,
                      imageWidth: 25,
                    ),
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 20),
          SizedBox(height: Get.height * 0.07),
          Container(
            height: 100,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.LargeTextColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Skeleton.replace(
                  replacement: Container(
                    height: 50,
                    width: 50,
                    color: Colors.grey[800],
                  ),
                  child: AssetImageWidget(
                    coinsicon,
                    imageHeight: 50,
                  ),
                ),
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
                            text: controller.isLoading.value ? "Total Points" : "Total Points",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Mulish",
                            ),
                          ).marginSymmetric(horizontal: 10),
                          Row(
                            children: [
                              TextView(
                                text: controller.isLoading.value
                                    ? "0000"
                                    : "${controller.userResponseModel?.value.data?.totalPoints}",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "TOMMYSOFT",
                                ),
                              ),
                              TextView(
                                text: controller.isLoading.value
                                    ? "(\$0)"
                                    : "(\$${controller.userResponseModel?.value.data?.totalPoints})",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Mulish",
                                ),
                              ).marginSymmetric(horizontal: 4),
                            ],
                          ).marginSymmetric(horizontal: 10, vertical: 10),
                        ],
                      ),
                      Skeleton.replace(
                        replacement: Container(
                          height: 20,
                          width: 20,
                          color: Colors.grey[800],
                        ),
                        child: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: margin_20),
          ).marginSymmetric(horizontal: 20),
          SizedBox(height: 20),
          Container(
            height: height_130,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: controller.isLoading.value ? 4 : controller.tabs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!controller.isLoading.value && controller.tabs[index] == "Spin a Wheel") {
                        Get.toNamed(AppRoutes.SpinWheelRoute);
                      }
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: Skeleton.replace(
                              replacement: Container(
                                height: 35,
                                width: 35,
                                color: Colors.grey[800],
                              ),
                              child: AssetImageWidget(
                                index == 0
                                    ? Acheievements
                                    : index == 1
                                    ? iconScanner
                                    : index == 2
                                    ? iconInviteFriend
                                    : iconSpin,
                                imageHeight: 25,
                                imageFitType: BoxFit.contain,
                                imageWidth: 25,
                              ).marginSymmetric(horizontal: 15),
                            ),
                          ).marginSymmetric(horizontal: 10),
                          SizedBox(height: 10),
                          TextView(
                            text: controller.isLoading.value ? "Loading..." : controller.tabs[index],
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Mulish",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ).marginSymmetric(horizontal: 10),
          ).marginSymmetric(horizontal: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: controller.isLoading.value ? "Popular Restaurants" : "Popular Restaurants",
                textAlign: TextAlign.center,
                maxLines: 1,
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontFamily: "TOMMYSOFT",
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!controller.isLoading.value) {
                    Get.toNamed(AppRoutes.ResturantRoute);
                  }
                },
                child: Row(
                  children: [
                    TextView(
                      text: controller.isLoading.value ? "View All" : "View All",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 12,
                        fontFamily: "TOMMYSOFT",
                      ),
                    ),
                    Skeleton.replace(
                      replacement: Container(
                        height: 12,
                        width: 12,
                        color: Colors.grey[800],
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 12,
                      ),
                    ).marginSymmetric(horizontal: 5),
                  ],
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 20, vertical: 20),
          Container(
            height: height_120,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.isLoading.value
                  ? 3
                  : controller.userResponseModel?.value.data?.popularRestaurants?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!controller.isLoading.value) {
                      Get.toNamed(AppRoutes.OffersRoute,
                          arguments: {
                            "id": "${controller.userResponseModel.value.data?.popularRestaurants?[index].sId}"
                          });
                    }
                  },
                  child: SizedBox(
                    width: Get.width / 3.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          child: Skeleton.replace(
                            replacement: Container(
                              height: 35,
                              width: 35,
                              color: Colors.grey[800],
                            ),
                            child: AssetImageWidget(
                              index == 0
                                  ? iconStarBucks
                                  : index == 1
                                  ? iconMc
                                  : index == 2
                                  ? iconHm
                                  : iconBk,
                              imageHeight: 35,
                              imageFitType: BoxFit.cover,
                              imageWidth: 35,
                            ),
                          ),
                        ).marginSymmetric(horizontal: 5),
                        SizedBox(height: 10),
                        TextView(
                          text: controller.isLoading.value
                              ? "Restaurant Name"
                              : controller.userResponseModel?.value.data?.popularRestaurants?[index].restaurantName ??
                              "",
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Mulish",
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ).marginOnly(left: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: controller.isLoading.value ? "Offers Available" : "Offers Available",
                textAlign: TextAlign.center,
                maxLines: 1,
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontFamily: "TOMMYSOFT",
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!controller.isLoading.value) {
                    Get.toNamed(AppRoutes.OffersRoute);
                  }
                },
                child: Row(
                  children: [
                    TextView(
                      text: controller.isLoading.value ? "View All" : "View All",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 12,
                        fontFamily: "TOMMYSOFT",
                      ),
                    ),
                    Skeleton.replace(
                      replacement: Container(
                        height: 12,
                        width: 12,
                        color: Colors.grey[800],
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 12,
                      ),
                    ).marginSymmetric(horizontal: 5),
                  ],
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 20).marginOnly(top: margin_10),
          Container(
            height: height_220,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.isLoading.value
                  ? 2
                  : controller.userResponseModel?.value.data?.offersAvailable?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!controller.isLoading.value) {
                      Get.toNamed(AppRoutes.OffersDetails,
                          arguments: {
                            "id": controller.userResponseModel?.value.data?.offersAvailable?[index]?.sId
                          });
                    }
                  },
                  child: Container(
                    width: Get.width * 0.7,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton.replace(
                          replacement: Container(
                            height: height_120,
                            width: Get.width,
                            color: Colors.grey[800],
                          ),
                          child: AssetImageWidget(
                            offerCoverImage,
                            imageHeight: height_120,
                            imageWidth: Get.width,
                            imageFitType: BoxFit.cover,
                            radiusTopLeft: 10,
                            radiusTopRight: 10,
                          ),
                        ),
                        TextView(
                          text: controller.isLoading.value
                              ? "Restaurant Name"
                              : "${controller.userResponseModel?.value.data?.offersAvailable?[index]?.restaurantId?.restaurantName}",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Mulish",
                          ),
                        ).marginSymmetric(horizontal: margin_10, vertical: margin_10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                              text: controller.isLoading.value
                                  ? "Offer Name"
                                  : "${controller.userResponseModel?.value.data?.offersAvailable?[index]?.offerName}",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Mulish",
                              ),
                            ),
                            TextView(
                              text: controller.isLoading.value
                                  ? "0 Visits"
                                  : "${controller.userResponseModel?.value.data?.offersAvailable?[index]?.visits} Visits",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Mulish",
                              ),
                            ),
                          ],
                        ).marginSymmetric(horizontal: margin_10),
                      ],
                    ),
                  ),
                ).marginSymmetric(horizontal: 10, vertical: 20);
              },
            ),
          ),
        ],
      ),
    ).marginOnly(top: margin_10)),
  );
}