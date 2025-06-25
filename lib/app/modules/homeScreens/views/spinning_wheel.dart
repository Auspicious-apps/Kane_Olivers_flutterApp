import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pp_spin_wheel/pp_spin_wheel.dart';

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
                  textStyle: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(
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
              PPSpinWheel(

                key: GlobalKey<PPSpinWheelState>(),
                size: Get.width * 0.8,
                backgroundSize: Get.width * 0.8,
                wheelSize: Get.width * 0.72,
                indicatorAnimateStyle: 0,
                enableWeight: false,


                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                items: [
                  PPSpinWheelItem(
                    title: 'Best of Luck',
                    bgColor: Colors.red,
                    weight: 1.0,
                    selected: false,

                  ),
                  PPSpinWheelItem(
                    title: '400 Points',
                    bgColor: Colors.green,
                    weight: 1.0,
                    selected: false,

                  ),
                  PPSpinWheelItem(
                    title: '800 Points',
                    bgColor: Colors.blue,
                    weight: 1.0,
                    selected: false,

                  ),
                  PPSpinWheelItem(
                    title: '7000 Points',
                    bgColor: Colors.yellow,
                    weight: 1.0,
                    selected: false,

                  ),
                  PPSpinWheelItem(
                    title: '5000 Points',
                    bgColor: Colors.purple,
                    weight: 1.0,
                    selected: false,

                  ),
                  PPSpinWheelItem(
                    title: '300 Points',
                    bgColor: Colors.orange,
                    weight: 1.0,
                    selected: false,

                  ),
                  PPSpinWheelItem(
                    title: '2000 Points',
                    bgColor: Colors.cyan,
                    weight: 1.0,
                    selected: false,

                  ),
                  PPSpinWheelItem(
                    title: '100 Points',
                    bgColor: Colors.white,
                    weight: 1.0,
                    selected: false,

                  ),
                ],
                numberOfTurns: 40,
                onAnimationEnd: (index) {
                  controller.addDivider(index + 1);
                  controller.stopSpinAudio();
                },
                onStartPressed: () {
                  if (controller.freeSpin.value == 0) {

                    controller.freeSpin.value--;
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
                  if(controller.freeSpin.value >0){
                    controller.playSpinAudio();
                    controller.freeSpin.value--;
                  }
                },
                onCannotSpin: () {
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
                },
              ).marginSymmetric(horizontal: 36, vertical: 36),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.6), // Adjust spacing for result display
                  Obx (()=> controller.freeSpin.value<0? SizedBox()  :StreamBuilder<int>(
                      stream: controller.dividerStream,
                      builder: (context, snapshot) {
                        print(RouletteScore.labels[snapshot.data]);
                        return snapshot.hasData
                            ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                           " ${RouletteScore.labels[snapshot.data]!=""?
                                        'You won ${RouletteScore.labels[snapshot.data] ?? 'Spin Again'}!'
                                      :"Better Luck Next Time"}",
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
                    )),
                  ],
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
}