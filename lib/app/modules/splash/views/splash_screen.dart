import 'package:OLIVERS/app/core/widget/annotated_region_widget.dart';

import '../../../export.dart';

import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(

        init: SplashController(),
        builder: (controller) {
          return AnnotatedRegionWidget(

            statusBarBrightness: Brightness.light,
            statusBarColor:AppColors.backgroundColor ,
            bottomColor:AppColors.backgroundColor,
            child: Scaffold(

              backgroundColor:AppColors.backgroundColor,

              body: Center(child: AssetImageWidget(iconSplashBackground,imageHeight: height_100,imageWidth: width_170,)),
            ),
          );
        });
  }
}
