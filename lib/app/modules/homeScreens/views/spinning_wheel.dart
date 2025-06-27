import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../../../core/widget/annotated_region_widget.dart';
import '../../../export.dart';
import '../controller/spinning_wheel_controller.dart';

class SpinningWheel extends GetView<SpinningWheelController> {
  const SpinningWheel({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = Get.width;
    final double screenHeight = Get.height;

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
                  text: "Spin a Wheel",
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
        SizedBox(height: Get.height * 0.15),
        Center(
          child: Stack(
            children: [
              Image.asset(
                'assets/images/spinframe.png',
                fit: BoxFit.contain,
              ).marginSymmetric(horizontal: margin_10, vertical: 14),
              SizedBox(
                height: Get.width * 0.85,
                width: Get.width * 0.85,

                child: FortuneWheel(
                  animateFirst:false,
                  selected: controller.selectedController.stream,
                  // duration:Duration(seconds: 6),
                  // indicators: [],

                  items: [
                    FortuneItem(
                        child: const Text('Best of Luck',
                            style: TextStyle(color: Colors.black)),
                        style: FortuneItemStyle(
                            color: Colors.red,
                            borderColor: Colors.white,
                            borderWidth: 2)),
                    FortuneItem(
                        child: const Text('7000 Points',
                            style: TextStyle(color: Colors.black)),
                        style: FortuneItemStyle(
                            color: Colors.green,
                            borderColor: Colors.white,
                            borderWidth: 2)),
                    FortuneItem(
                        child: const Text('5000 Points',
                            style: TextStyle(color: Colors.black)),
                        style: FortuneItemStyle(
                            color: Colors.blue,
                            borderColor: Colors.white,
                            borderWidth: 2)),
                    FortuneItem(
                        child: const Text('2000 Points',
                            style: TextStyle(color: Colors.black)),
                        style: FortuneItemStyle(
                            color: Colors.yellow,
                            borderColor: Colors.white,
                            borderWidth: 2)),
                    FortuneItem(
                        child: const Text('400 Points',
                            style: TextStyle(color: Colors.black)),
                        style: FortuneItemStyle(
                            color: Colors.purple,
                            borderColor: Colors.white,
                            borderWidth: 2)),
                    FortuneItem(
                        child: const Text('100 Points',
                            style: TextStyle(color: Colors.black)),
                        style: FortuneItemStyle(
                            color: Colors.orange,
                            borderColor: Colors.white,
                            borderWidth: 2)),
                  ],
                  onAnimationEnd: () {
                    controller.addDivider(RouletteScore.getIndex('7000 Points')); // Match spin result
                    controller.stopSpinAudio();
                // Show popup after 3 seconds
                  },
                ),

              ).marginSymmetric(horizontal: 25, vertical:10),
              Positioned(
                  top: Get.width/2.4,
                  left: Get.width/2.5,
                  child: Container(height: 30,width: 30,decoration: BoxDecoration(color: Color.fromRGBO(208,155,79, 1),borderRadius: BorderRadius.circular(20)),)),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.65),
                  // Space between result text and button
                  ElevatedButton(
                        onPressed: () {
                          controller.spinToBestOfLuck();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric( vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.touch_app,color: Colors.white,),
                             Text(
                              "Spin",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: "TOMMYSOFT",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ).marginSymmetric(horizontal: 30),

                  ],
                ),
              ),
            ],
          ),
        ).marginSymmetric(horizontal: 20),
      ],
    ),
  );
}

class RouletteScore {
  static final Map<int, String> labels = {
    1: '',
    2: '7000 Points',
    3: '5000 Points',
    4: '2000 Points',

    5: '400 Points',

    6: '100 Points',
  };

  static int getIndex(String label) {
    return labels.entries
        .firstWhere((entry) => entry.value == label,
        orElse: () => const MapEntry(1, ''))
        .key;
  }
}