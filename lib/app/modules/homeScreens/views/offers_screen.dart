import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/core/widget/network_image_widget.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/bindings/home_screen_binding.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';
import 'package:OLIVERS/app/modules/homeScreens/controller/Resturant_controller.dart';
import 'package:OLIVERS/app/modules/homeScreens/controller/offers_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/validator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OffersScreen extends GetView<OffersController> {
  const OffersScreen({super.key});

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

  Widget _body(BuildContext context) => Obx(() => Skeletonizer(
    enabled: controller.isLoading.value,
    effect: ShimmerEffect(
      baseColor: Colors.grey[900]!,
      highlightColor: Colors.grey[800]!,
      duration: Duration(seconds: 1),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(35),
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
                child: TextView(
                  text: "Offers Available",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.LargeTextColor,
                    fontSize: 24,
                    fontFamily: "TOMMYSOFT",
                  ),
                ),
              ),
            ),
          ],
        ).marginOnly(top: margin_14, left: 20),
        SizedBox(height: Get.height * 0.07),
        Expanded(
          child: Container(
            width: Get.width,
            child: controller.userResponseModel.value.data?.restaurantOffers?.isNotEmpty == false
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: "No Offer Found!",
                    textStyle: TextStyle(
                      color: AppColors.whiteColor.withOpacity(0.7),
                      fontSize: 18,
                      fontFamily: "TOMMYSOFT",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextView(
                    text: "We're still adding new merchants! Check back soon for more options.",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: AppColors.whiteColor.withOpacity(0.5),
                      fontSize: 14,
                      fontFamily: "Mulish",
                    ),
                  ).marginOnly(top: 8, left: 20, right: 20),
                ],
              ),
            )
                : ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: controller.userResponseModel?.value.data?.restaurantOffers?.length ?? 3, // Default to 3 for skeleton
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!controller.isLoading.value) {
                      Get.toNamed(AppRoutes.OffersDetails,
                          arguments: {
                            "id": controller.userResponseModel?.value.data?.restaurantOffers?[index]?.sId
                          });
                    }
                  },
                  child: Container(
                    width: Get.width * 0.7,
                    height: Get.height / 4,
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
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
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
                        Skeleton.replace(
                          replacement: Container(
                            height: 14,
                            width: Get.width * 0.5,
                            color: Colors.grey[900],
                          ),
                          child: TextView(
                            text: "${controller.userResponseModel?.value.data?.restaurantOffers?[index]?.restaurantId?.restaurantName ?? "Restaurant Name"}",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Mulish",
                            ),
                          ),
                        ).marginSymmetric(horizontal: margin_10, vertical: margin_10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Skeleton.replace(
                              replacement: Container(
                                height: 12,
                                width: Get.width * 0.3,
                                color: Colors.grey[900],
                              ),
                              child: TextView(
                                text: "${controller.userResponseModel?.value.data?.restaurantOffers?[index]?.offerName ?? "Offer Name"}",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Mulish",
                                ),
                              ),
                            ),
                            Skeleton.replace(
                              replacement: Container(
                                height: 12,
                                width: Get.width * 0.2,
                                color: Colors.grey[900],
                              ),
                              child: TextView(
                                text: "${controller.userResponseModel?.value.data?.restaurantOffers?[index]?.visits ?? "0"} Visits",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Mulish",
                                ),
                              ),
                            ),
                          ],
                        ).marginSymmetric(horizontal: margin_10),
                      ],
                    ),
                  ).marginSymmetric(horizontal: 10, vertical: 20),
                );
              },
            ),
          ).marginOnly(left: 10, right: 10),
        ),
      ],
    ),
  )).marginOnly(top: margin_10);
}