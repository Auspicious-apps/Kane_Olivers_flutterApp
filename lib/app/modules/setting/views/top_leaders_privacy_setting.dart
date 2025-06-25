import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import '../controller/top_leader_privacy_setting_controller.dart';

class TopLeadersPrivacySetting extends GetView<TopLeaderPrivacySettingController> {
  const TopLeadersPrivacySetting({super.key});


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
                )),
            Container(
              width: Get.width*0.7,
              child: Center(
                child: TextView(
                  text: "Top Leader Privacy",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
                text: "Hide My Leaderboard Stats",
                textAlign: TextAlign.center,
                maxLines: 1,
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 16,

                  fontFamily: "TOMMYSOFT",
                )).marginSymmetric(horizontal:10),
            Obx(
                  () => Switch(
                value: controller.hideLeaderboardStats.value,
                onChanged: (value) {
                  controller.hideLeaderboardStats.value = value;

                },
                activeTrackColor: Colors.green, // Green background when switch is active
                inactiveTrackColor: Colors.grey.withOpacity(0.5),

                thumbColor: WidgetStateProperty.all(Colors.white), // White thumb in both states
              ),
            ),
          ],
        ).marginOnly(top:margin_50),

        TextView(
            text: "Turn this on to hide your points and ranking from other users on the leaderboard. You’ll still be able to view your own progress, but others won’t see your stats.",
            textAlign: TextAlign.start,
            maxLines: 5,
            textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.w900,

              fontFamily: "Mulish",
            )).marginSymmetric(horizontal:10,vertical: 10),
      ],
    ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
  );
}