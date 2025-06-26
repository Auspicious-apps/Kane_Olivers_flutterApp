


import 'package:OLIVERS/app/modules/setting/models/ResponseModels/staticResponseModel.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../export.dart';
import '/app/core/base/base_controller.dart';

class Staticpagecontroller extends BaseController {

  RxBool isloading=false.obs;
  var otp ="".obs;
  Rx<StaticResponseModel> userResponseModel=Rx<StaticResponseModel>(StaticResponseModel());

  @override
  void onInit() {
    if(Get.arguments!=null){
      otp.value=Get.arguments["otp"];
      fetchHomeData();
    }
    super.onInit();
  }



  fetchHomeData({String? value}) {
    isloading.value=true;
    isloading.refresh();
    try{
      repository.StaticApi(query: {"type":otp.value=="Privacy Policy"?"privacyPolicy":otp.value=="Terms & Conditions"?"terms":"support"}).then((value) async {
        if (value != null) {
          userResponseModel.value = value;
          isloading.value=false;
          isloading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value=false;
        isloading.refresh();
        Get.snackbar('Error', '${er}');
      });
    }catch(er){
      isloading.value=false;
      isloading.refresh();
      print("$er");
    }
  }





  void skipPage() {


  }

  @override
  void dispose() {

    super.dispose();
  }


}
