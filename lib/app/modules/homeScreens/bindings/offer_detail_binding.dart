

import 'package:OLIVERS/app/modules/AuthModule/controllers/forget_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';
import 'package:OLIVERS/app/modules/homeScreens/controller/Resturant_controller.dart';
import 'package:OLIVERS/app/modules/homeScreens/controller/offers_controller.dart';

import '../../../export.dart';
import '../controller/offer_detail_controller.dart';
import '../controller/spinning_wheel_controller.dart';
class OfferDetailBinding  extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferDetailController>(
          () => OfferDetailController(),
    );
  }
}
