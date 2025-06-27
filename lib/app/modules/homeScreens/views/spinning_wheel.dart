import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spinning_wheel/spinning_wheel.dart';
import 'dart:math';

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
                      textStyle:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
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
                  ).marginSymmetric(horizontal: margin_30, vertical: 30),
                  SizedBox(
                    height: Get.width * 0.9,
                    width: Get.width * 0.9,
                    child: SpinnerWheel(
                      controller: controller.spinnerController,
                      labelStyle: TextStyle(color: Colors.black),
                      wheelColor: Colors.transparent,

                      segments: [
                        WheelSegment('Best of Luck', Colors.red, 0),
                        WheelSegment('400 Points', Colors.green, 400),
                        WheelSegment('800 Points', Colors.blue, 800),
                        WheelSegment('7000 Points', Colors.yellow, 7000),
                        WheelSegment('5000 Points', Colors.purple, 5000),
                        WheelSegment('300 Points', Colors.orange, 300),
                      ],
                      onComplete: (win) {
                        controller
                            .addDivider(RouletteScore.getIndex(win.label));
                        controller.stopSpinAudio();
                        if (win.value > 0) {
                          // Handle points addition if needed
                        }
                      },
                    ),
                  ).marginSymmetric(horizontal: 20, vertical: 18),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height * 0.6),
                        Obx(
                          () => controller.freeSpin.value < 0
                              ? SizedBox()
                              : StreamBuilder<int>(
                                  stream: controller.dividerStream,
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              "${RouletteScore.labels[snapshot.data] != '' ? 'You won ${RouletteScore.labels[snapshot.data] ?? 'Spin Again'}!' : 'Better Luck Next Time'}",
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 24.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : Container();
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 147,
                    child: GestureDetector(
                      onTap: (){
                        controller.isSpinning.value
                              ? null
                              : () {
                          if (controller.freeSpin.value <= 0) {
                            Get.dialog(
                              AlertDialog(
                                title: Text('No Free Spins'),
                                content: Text('You have no free spins left!'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                              barrierDismissible: false,
                            );
                            return;
                          }
                          controller.playSpinAudio();
                          controller.freeSpin.value--;
                          controller.spinnerController.startSpin();
                        };
                      },
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: ElevatedButton(
                          onPressed: controller.isSpinning.value
                              ? null
                              : () {
                            if (controller.freeSpin.value <= 0) {
                              Get.dialog(
                                AlertDialog(
                                  title: Text('No Free Spins'),
                                  content: Text('You have no free spins left!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                                barrierDismissible: false,
                              );
                              return;
                            }
                            controller.playSpinAudio();
                            controller.freeSpin.value--;
                            controller.spinnerController.startSpin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                           Colors.amber,
                            
                          ),
                          child: Text(
                           "Go",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: "TOMMYSOFT"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      );
}

class RouletteScore {
  static final Map<int, String> labels = {
    1: '',
    2: '400 Points',
    3: '800 Points',
    4: '7000 Points',
    5: '5000 Points',
    6: '300 Points',
    7: '2000 Points',
    8: '100 Points',
  };

  static int getIndex(String label) {
    return labels.entries
        .firstWhere((entry) => entry.value == label,
            orElse: () => MapEntry(1, ''))
        .key;
  }
}
