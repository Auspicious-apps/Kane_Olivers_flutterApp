import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../controller/offer_detail_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OfferDetailScreen extends GetView<OfferDetailController> {
  const OfferDetailScreen({super.key});

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

  Widget _body(BuildContext context) => GetBuilder<OfferDetailController>(
    builder: (controller) => Obx(() => Skeletonizer(
      enabled: controller.isLoading.value,
      effect: ShimmerEffect(
        baseColor: Colors.grey[900]!,
        highlightColor: Colors.grey[800]!,
        duration: Duration(seconds: 1),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Skeleton.replace(
                      replacement: Container(
                        height: 24,
                        width: Get.width * 0.5,
                        color: Colors.grey[900],
                      ),
                      child: TextView(
                        text: "${controller.userResponseModel.value.data?.restaurantId?.restaurantName ?? ""}",
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
                ),
              ],
            ).marginOnly(top: margin_14, left: 20),
            SizedBox(height: Get.height * 0.07),
            Skeleton.replace(
              replacement: Container(
                height: height_170,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: AssetImageWidget(
                offerCoverImage,
                imageHeight: height_170,
                imageWidth: Get.width,
                imageFitType: BoxFit.cover,
                radiusAll: 10,
              ),
            ).marginSymmetric(horizontal: height_20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton.replace(
                  replacement: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      4, // Mimic description with 4 lines
                          (index) => Container(
                        height: 14,
                        width: Get.width * (0.7 + index * 0.05),
                        color: Colors.grey[900],
                        margin: EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  ),
                  child: TextView(
                    text: "${controller.userResponseModel.value.data?.description ?? ""}",
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.subHeadingColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Mulish",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Skeleton.replace(
                  replacement: Container(
                    height: 14,
                    width: Get.width * 0.4,
                    color: Colors.grey[900],
                  ),
                  child: TextView(
                    text: "Unlock Rewards",
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.subHeadingColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "TOMMYSOFT",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Skeleton.replace(
                  replacement: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      3, // Mimic unlock rewards with 3 lines
                          (index) => Container(
                        height: 14,
                        width: Get.width * (0.65 + index * 0.05),
                        color: Colors.grey[900],
                        margin: EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  ),
                  child: TextView(
                    text: "${controller.userResponseModel.value.data?.unlockRewards ?? ""}",
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.subHeadingColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Mulish",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Skeleton.replace(
                  replacement: Container(
                    height: 14,
                    width: Get.width * 0.4,
                    color: Colors.grey[900],
                  ),
                  child: TextView(
                    text: "Redeem In-Store",
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.subHeadingColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "TOMMYSOFT",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Skeleton.replace(
                  replacement: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      3, // Mimic redeem in-store with 3 lines
                          (index) => Container(
                        height: 14,
                        width: Get.width * (0.6 + index * 0.05),
                        color: Colors.grey[900],
                        margin: EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  ),
                  child: TextView(
                    text: "${controller.userResponseModel.value.data?.redeemInStore ?? ""}",
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.subHeadingColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Mulish",
                    ),
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: 20, vertical: 20),
          ],
        ).marginOnly(top: margin_10),
      ),
    )),
  );
}