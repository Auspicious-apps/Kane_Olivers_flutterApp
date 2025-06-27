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
import 'package:skeletonizer/skeletonizer.dart';

class Resturantscreen extends GetView<ResturantController> {
  const Resturantscreen({super.key});

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
    child: Obx(()=>Skeletonizer(
      enabled: controller.isLoading.value,
      effect: ShimmerEffect(
        baseColor: Colors.grey[900]!, // Dark base for dark mode
        highlightColor: Colors.grey[700]!, // Subtle highlight
        duration: const Duration(seconds: 1),
      ),
      textBoneBorderRadius:  TextBoneBorderRadius(BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (!controller.isLoading.value) {
                    Get.back();
                  }
                },
                child: Skeleton.leaf(
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Skeleton.replace(
                      replacement: Container(
                        height: 20,
                        width: 20,
                        color: Colors.grey[800],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                    ).marginOnly(left: 8),
                  ),
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
          SizedBox(height: Get.height * 0.07),
          // Search Bar
          Skeleton.leaf(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: controller.isLoading.value
                      ? Colors.grey[800]!
                      : Colors.white.withOpacity(0.2),
                ),
              ),
              child: Skeleton.replace(
                replacement: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  enabled: !controller.isLoading.value,
                  controller: controller.searchController,
                  onChanged: (value) {
                    if (!controller.isLoading.value) {
                      controller.fetchHomeData(value: value);
                    }
                  },
                  style: const TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 16,
                    fontFamily: "Mulish",
                  ),
                  decoration: InputDecoration(
                    hintText: "Search Restaurants...",
                    hintStyle: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontFamily: "Mulish",
                    ),
                    prefixIcon: Skeleton.replace(
                      replacement: Container(
                        height: 24,
                        width: 24,
                        color: Colors.grey[800],
                      ),
                      child: const Icon(
                        Icons.search,
                        color: AppColors.blackColor,
                        size: 24,
                      ),
                    ),
                    suffixIcon: controller.isLoading.value
                        ? null
                        : controller.searchController.text.isNotEmpty
                        ? GestureDetector(
                      onTap: () {
                        if (!controller.isLoading.value) {
                          controller.clearSearch();
                        }
                      },
                      child: Skeleton.replace(
                        replacement: Container(
                          height: 24,
                          width: 24,
                          color: Colors.grey[800],
                        ),
                        child: Icon(
                          Icons.clear,
                          color: AppColors.whiteColor.withOpacity(0.6),
                          size: 24,
                        ),
                      ),
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Container(
            width: Get.width,
            height: Get.height * 0.7, // Explicit height to constrain GridView
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: controller.isLoading.value || (controller.userResponseModel.value.data?.restaurants?.isEmpty ?? true)
                ? GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: controller.isLoading.value ? 4 : 0,
              itemBuilder: (context, index) {
                return Skeleton.leaf(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Skeleton.replace(
                          replacement: Container(
                            height: 70,
                            width: 70,
                            color: Colors.grey[800],
                          ),
                          child: Container(
                            height: 70,
                            width: 70,
                            color: Colors.grey[800], // Placeholder for skeleton
                          ),
                        ).marginSymmetric(horizontal: 5),
                        const SizedBox(height: 10),
                        TextView(
                          text: "Restaurant Name",
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
                  ),
                );
              },
            )
                : GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: controller.isLoading.value ? 4 : controller.userResponseModel.value.data?.restaurants?.length ?? 0,
              itemBuilder: (context, index) {
                final restaurant = controller.userResponseModel.value.data?.restaurants?[index];
                return GestureDetector(
                  onTap: () {
                    if (!controller.isLoading.value) {
                      Get.toNamed(AppRoutes.OffersRoute,
                          arguments: {"id": "${controller.userResponseModel.value.data?.restaurants?[index].sId}"});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Skeleton.replace(
                          replacement: Container(
                            height: 70,
                            width: 70,
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
                            imageHeight: 70,
                            imageFitType: BoxFit.cover,
                            imageWidth: 70,
                          ),
                        ).marginSymmetric(horizontal: 5),
                        const SizedBox(height: 10),
                        TextView(
                          text: controller.isLoading.value ? "Restaurant Name" : restaurant?.restaurantName ?? "",
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
                  ),
                );
              },
            ),
          ).marginOnly(left: 20, right: 20),

        ],
      ),
    ).marginOnly(top: margin_10)),
  );
}