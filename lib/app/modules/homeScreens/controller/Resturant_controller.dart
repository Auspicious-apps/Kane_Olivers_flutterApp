import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../export.dart';
import '../../homeScreens/models/responseModels/HomeResponseModel.dart';
import '../models/responseModels/ResturantsResponseModel.dart';
import '/app/core/base/base_controller.dart';

class ResturantController extends BaseController {

  TextEditingController? emailController;
  TextEditingController searchController = TextEditingController();

  final List tabs=["Collect Stamp","Unique Code","Invite Friends","Spin a Wheel"];

  final List resturants=["Starbucks","McDonals","Hermer","Burger King","Hungry Point"];

  RxBool isLoading = false.obs;
  RxList<PopularRestaurants> filteredRestaurants = <PopularRestaurants>[].obs;

  FocusNode? emailFocusNode;
  Rx<ResturantsResponseModel> userResponseModel=Rx<ResturantsResponseModel>(ResturantsResponseModel());

  @override
  void onInit() {
    fetchHomeData();
    super.onInit();
  }





  fetchHomeData({String? value}) {
    isLoading.value=true;
    isLoading.refresh();
    try{
      repository.GetAllResturantsApi(query: {"description":value?.trim(),"limit":30,"page":1}).then((value) async {
        if (value != null) {
          userResponseModel.value = value;
          isLoading.value=false;
          isLoading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value=false;
        isLoading.refresh();
        Get.snackbar('Error', '${er}');
      });
    }catch(er){
      isLoading.value=false;
      isLoading.refresh();
      print("$er");
    }
  }

  void clearSearch() {
    searchController.clear();
  }

  void skipPage() {

    // Get.offAllNamed(AppRoutes.mainScreenRoute);
  }

  @override
  void dispose() {
    _disposeEditTextController();
    _disposeFocusNode();
    searchController.dispose();
    super.dispose();
  }

  /*======================= dispose all edit text controllers that are used =======================*/

  _disposeEditTextController() {

    emailController?.dispose();

  }

  /*======================= dispose all focus nodes that are used in this controller =================*/

  _disposeFocusNode() {

    emailFocusNode?.dispose();

  }
}
