

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../controllers/on_boarding_controller.dart';
import '../widgets/onboarding_item.dart';
import 'package:OLIVERS/app/export.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return  AnnotatedRegionWidget(

      statusBarBrightness: Brightness.light,
      statusBarColor:AppColors.blackColor ,
      bottomColor:AppColors.blackColor,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() => Obx(
        () => Column(
      children: [
        Expanded(
          child: _pageView(),
        ),
        _buttons(),
      ],
    ),
  );

  Widget _pageView() => PageView.builder(
    controller: controller.pageController.value,
    itemCount: controller.listItem.length,
    physics: const ClampingScrollPhysics(),
    onPageChanged: (value) {
      controller.selectedIndex.value = value;
    },
    itemBuilder: (context, index) {
      var item = controller.listItem[index];
      return _pageContent(item);
    },
  );

  Widget _pageContent(OnBoardingItem item) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _image(item),
      _content(item).marginOnly(top: margin_50),
      _indicators(),


    ],
  );

  Widget _image(OnBoardingItem item) => Container(
    margin: EdgeInsets.symmetric(vertical: margin_15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AssetImageWidget(
        item.image ?? "",
        imageHeight: Get.height * 0.35, // Slightly reduced for balance
        imageWidth: Get.width * 0.8, // Constrain width for clarity
        imageFitType: BoxFit.contain,
      ),
    ),
  );

  Widget _content(OnBoardingItem item) => Container(
    padding: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_10),
    child: OnBoardingItem(
      heading: item.heading,
      subheading: item.subheading,

    ),
  );

  Widget _indicators() => Container(
    height: margin_10,
    margin: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_10),
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: controller.listItem.length,
      itemBuilder: (context, index) {
        return Obx(() => Container(
          width:controller.selectedIndex.value == index?margin_30 :margin_10,
          height: margin_5,
          margin: EdgeInsets.only(right: margin_5),
          decoration: BoxDecoration(
            color: controller.selectedIndex.value == index
                ? AppColors.whiteColor // Darker for active indicator
                : AppColors.greyColor.withOpacity(0.3), // Lighter for inactive
            borderRadius: BorderRadius.circular(30),
            // border: Border.all(
            //   color: controller.selectedIndex.value == index
            //       ? AppColors.whiteColor
            //       : AppColors.greyColor,
            //   width: 1.0,
            // ),
          ),
        ));
      },
    ),
  );

  Widget _buttons() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (controller.selectedIndex.value != 2)
        _prevButton().paddingOnly(right: margin_15),
      Expanded(child: _nextButton()),
    ],
  ).paddingSymmetric(horizontal: margin_15, vertical: margin_15);

  Widget _prevButton() => SizedBox(
    width: (Get.width - 3 * margin_15) / 2,
    child: MaterialButtonWidget(
      buttonBgColor: Colors.white,
      isOutlined: false,
      borderColor: AppColors.appDarkColor,
      borderWidth: margin_2,
      buttonText: "Skip",
      textColor: AppColors.backgroundColor,
      buttonRadius: margin_40,
      onPressed: () {
        controller.skipPage();
      },
    ),
  );

  Widget _nextButton() => MaterialButtonWidget(
    buttonBgColor: AppColors.LargeTextColor,
    buttonRadius: margin_40,
    buttonText: controller.selectedIndex.value != 2 ? "Continue" :"Let’s Get Started",
    textColor: AppColors.backgroundColor,
    onPressed: () {
      controller.movePageController();
    },
  );


}