import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:OLIVERS/app/core/widget/network_image_widget.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/Referal_Controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';
import 'package:OLIVERS/app/modules/AuthModule/controllers/sign_up_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/bindings/home_screen_binding.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';
import 'package:OLIVERS/app/modules/homeScreens/controller/Resturant_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/widget/intl_phone_field/country_picker_text_field.dart';
import '../../../core/widget/validator.dart';

class Resturantscreen extends GetView<ResturantController> {
  const Resturantscreen({super.key});

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

  Widget _body(BuildContext context) => Obx(() => Column(
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
                borderRadius: BorderRadius.circular(35),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ).marginOnly(left: 8),
            ),
          ),
          Container(
            width: Get.width * 0.7,
            child: Center(
              child: TextView(
                text: "Restaurant Lists",
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
      SizedBox(height: Get.height * 0.05),

      // Search Bar
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: TextField(
          onChanged:(value){
            controller.fetchHomeData(value: value);
          } ,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 16,
            fontFamily: "Mulish",
          ),
          decoration: InputDecoration(
            hintText: "Search restaurants...",
            hintStyle: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontFamily: "Mulish",
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.blackColor,
              size: 24,
            ),
            suffixIcon: controller.searchController.text.isNotEmpty
                ? GestureDetector(
                    onTap: controller.clearSearch,
                    child: Icon(
                      Icons.clear,
                      color: AppColors.whiteColor.withOpacity(0.6),
                      size: 24,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),



      SizedBox(height: Get.height * 0.02),

      Expanded(
        child: Container(
          width: Get.width,
          child: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  ),
                )
              : controller.userResponseModel.value.data?.restaurants?.isNotEmpty==false
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: AppColors.whiteColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          TextView(
                            text: controller.searchController.text.isNotEmpty
                                ? "No restaurants found"
                                : "No restaurants available",
                            textStyle: TextStyle(
                              color: AppColors.whiteColor.withOpacity(0.7),
                              fontSize: 18,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (controller.searchController.text.isNotEmpty)
                            TextView(
                              text: "Try a different search term",
                              textStyle: TextStyle(
                                color: AppColors.whiteColor.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: "Mulish",
                              ),
                            ).marginOnly(top: 8),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric( vertical: 10),
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        crossAxisSpacing: 16, // Space between columns
                        mainAxisSpacing: 16, // Space between rows
                        childAspectRatio: 0.8, // Adjust for image and text
                      ),
                      itemCount: controller.userResponseModel.value.data?.restaurants?.length??0,
                      itemBuilder: (context, index) {
                        final restaurant = controller.userResponseModel.value.data?.restaurants?[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AssetImageWidget(
                                index == 0
                                    ? iconStarBucks
                                    : index == 1
                                    ? iconMc
                                    : index == 2
                                    ? iconHm
                                    : iconBk,
                                imageHeight: 70,
                                imageFitType: BoxFit.cover,
                                imageWidth: 70,
                              ).marginSymmetric(horizontal: 5),
                              const SizedBox(height: 10),
                              TextView(
                                text: restaurant?.restaurantName ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Mulish",
                                ),
                              ).marginSymmetric(horizontal: 20),
                            ],
                          ),
                        );
                      },
                    ),
        ).marginOnly(left: 20, right: 20),
      ),
    ],
  )).marginOnly(top: margin_10);
}