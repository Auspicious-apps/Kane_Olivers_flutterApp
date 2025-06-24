


 import 'package:OLIVERS/app/modules/dashboard/controllers/home_screen_controller.dart';
import 'package:OLIVERS/app/modules/dashboard/controllers/setting_screen_controller.dart';

import '../../../export.dart';

double? currentLatitude;
 double? currentLongitude;
class BottomTabController extends GetxController{
 var from ;

  var selectedIndex = 0.obs;

  final homeController = Get.put(HomeScreenController());
  final settingController = Get.put(SettingScreenController());

  @override
  void onInit(){

    super.onInit();
  }



  @override
  void onReady(){

  }
  @override
  void dispose(){
    super.dispose();
  }



  void changeIndex(var index){

    selectedIndex.value=index;

  }
}