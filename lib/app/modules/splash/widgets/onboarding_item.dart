/*
 * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 * @author     : Gaurav Negi
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Henceforth Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import 'package:OLIVERS/app/export.dart';


class OnBoardingItem extends StatelessWidget {
  final String? image;
  final String? heading;
  final String? subheading;

  const OnBoardingItem({super.key,
    this.image,
    required this.heading,
    required this.subheading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextView(
          text: heading ?? "",
          maxLines: 3,
          textStyle: textStyleDisplayMedium().copyWith(color:AppColors.LargeTextColor,fontSize: font_22,fontFamily: "TOMMYSOFT"),
        ).paddingOnly(bottom: margin_4),
        SizedBox(height: height_11,),
        TextView(
          text: subheading ?? "",
          textAlign: TextAlign.center,
          maxLines: 4,
          textStyle: textStyleDisplaySmall().copyWith(color: AppColors.smallTextColor,fontSize: font_16,fontFamily: "Mulish"),
        ),
      ],
    ).paddingSymmetric(horizontal: margin_15);
  }
}
