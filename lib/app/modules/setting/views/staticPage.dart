import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../controller/staticPageController.dart';

class Staticpage extends GetView<Staticpagecontroller> {
  const Staticpage({super.key});

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

  Widget _body(BuildContext context) => GetBuilder<Staticpagecontroller>(
    builder: (controller) => Obx(() => Skeletonizer(
      enabled: controller.isloading.value,
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
                      text: controller.otp.value.isNotEmpty
                          ? controller.otp.value
                          : "Static Page",
                      textAlign: TextAlign.start,
                      textStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                        color: AppColors.LargeTextColor,
                        fontSize: 24,
                        fontFamily: "TOMMYSOFT",
                      ),
                    ).marginSymmetric(horizontal: 10),
                  ),
                ),
              ),
            ],
          ).marginOnly(top: margin_14),
          Expanded(
            child: controller.userResponseModel.value.data != null &&
                controller.userResponseModel.value.data!.isNotEmpty
                ? SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.replace(
                    replacement: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: Get.width * 0.9,
                          color: Colors.grey[900],
                          margin: EdgeInsets.only(bottom: 16),
                        ),
                        Container(
                          height: 80,
                          width: Get.width * 0.8,
                          color: Colors.grey[900],
                          margin: EdgeInsets.only(bottom: 16),
                        ),
                        Container(
                          height: 60,
                          width: Get.width * 0.85,
                          color: Colors.grey[900],
                        ),
                      ],
                    ),
                    child: Html(
                      data: controller
                          .userResponseModel.value.data!,
                      style: {
                        "h3": Style(
                          fontSize: FontSize(16),
                          color: AppColors.whiteColor,
                          fontFamily: "TOMMYSOFT",
                        ),
                        "p": Style(
                          fontSize: FontSize(16),
                          color: Colors.white,
                        ),
                        "li": Style(
                          fontSize: FontSize(16),
                          color: Colors.white,
                        ),
                      },
                    ),
                  ).marginOnly(top: margin_20),
                ],
              ),
            )
                : Center(
              child: Skeleton.replace(
                replacement: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    15, // Minimum 8 lines for skeleton UI
                        (index) => Container(
                      height: 16,
                      width: Get.width * (0.6),
                      color: Colors.grey[900],
                      margin: EdgeInsets.only(bottom: 8),
                    ),
                  ),
                ).marginSymmetric(vertical: 100),
                child: TextView(
                  text: "No content available",
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
    )),
  );
}