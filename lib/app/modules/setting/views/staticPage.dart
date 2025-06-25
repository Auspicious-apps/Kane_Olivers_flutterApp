import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:OLIVERS/app/export.dart';
import 'package:flutter_html/flutter_html.dart'; // Added for HTML rendering

import '../controller/staticPageController.dart';

class Staticpage extends GetView<Staticpagecontroller> {
  const Staticpage({super.key});

  // Static HTML content
  final String staticHtmlContent = '''
    <h2>1. Introduction</h2>
    <p>Welcome to our application ("App"). By accessing or using our App, you agree to be bound by these Terms and Conditions ("Terms"). If you do not agree with any part of these Terms, please do not use the App.</p>
    
    <h2>2. User Responsibilities</h2>
    <p>You agree to:</p>
    <ul>
      <li>Provide accurate and complete information during registration.</li>
      <li>Maintain the confidentiality of your account credentials.</li>
      <li>Use the App in compliance with all applicable laws and regulations.</li>
    </ul>
    
    <h2>3. Prohibited Activities</h2>
    <p>You may not:</p>
    <ul>
      <li>Use the App for any unlawful purpose.</li>
      <li>Attempt to hack, disrupt, or overload the App's infrastructure.</li>
      <li>Reproduce or distribute any content from the App without permission.</li>
    </ul>
    
    <h2>4. Limitation of Liability</h2>
    <p>The App is provided "as is" without warranties of any kind. We are not liable for any damages arising from your use of the App, including but not limited to direct, indirect, incidental, or consequential damages.</p>
    
    <h2>5. Changes to Terms</h2>
    <p>We reserve the right to modify these Terms at any time. Changes will be effective upon posting to the App. Your continued use of the App constitutes acceptance of the updated Terms.</p>
    
    <h2>6. Contact Us</h2>
    <p>If you have any questions about these Terms, please contact us at <a href="mailto:support@example.com">support@example.com</a>.</p>
  ''';
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
            Container(width:Get.width*0.7,
              child: Center(
                child: TextView(
                  text: "${controller.otp.value}",
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
        // Adding HTML content below the existing UI
        Html(
          data: staticHtmlContent,
          style: {
            "h2": Style(
              fontSize: FontSize(18),
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
        ).marginOnly(top: margin_20),
      ],
    ).marginOnly(top: margin_10).marginSymmetric(horizontal: 20),
  );
}