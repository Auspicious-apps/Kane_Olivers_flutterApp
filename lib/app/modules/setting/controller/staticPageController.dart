


import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../export.dart';
import '/app/core/base/base_controller.dart';

class Staticpagecontroller extends BaseController {

  RxBool isloading=false.obs;
  var otp ="".obs;


  @override
  void onInit() {
    if(Get.arguments!=null){
      otp.value=Get.arguments["otp"];
    }
    super.onInit();
  }









  void skipPage() {


  }

  @override
  void dispose() {

    super.dispose();
  }


}
