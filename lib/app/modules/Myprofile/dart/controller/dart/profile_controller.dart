import 'package:OLIVERS/app/modules/setting/models/ResponseModels/staticResponseModel.dart';
import 'package:get/get.dart';
import '../../../../../core/widget/intl_phone_field/countries.dart';
import '../../../../../export.dart';
import '../../../../AuthModule/models/responsemodels/userResponseModel.dart';
import '/app/core/base/base_controller.dart';

class ProfileController extends BaseController {
  final RxBool isLoading = false.obs;
  final RxString otp = ''.obs;
  final Rx<UserResponseModel> userResponseModel = UserResponseModel().obs;

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController referralCodeController = TextEditingController();
  final FocusNode referralCodeFocusNode = FocusNode();
  final TextEditingController mobileNumberTextController = TextEditingController();
  final FocusNode mobileNumberFocusNode = FocusNode();
  final TextEditingController genderController = TextEditingController();
  final FocusNode genderFocusNode = FocusNode();
  late Rx<Country> CountriesList;
  late Rx<Country> selectedCountry;

  @override
  void onInit() {
    super.onInit();
    _loadCountry();
    fetchProfileApi();
  }

  void _loadCountry() {
    final country = countries.firstWhere(
          (item) => item.code == 'GB',
      orElse: () => countries.first,
    );
    selectedCountry = country.obs;
  }

  Future<void> fetchProfileApi({String? value}) async {
    try {
      isLoading.value = true;
      final value = await repository.GetProfile();

      if (value != null) {
        userResponseModel.value = value;
        referralCodeController.text = userResponseModel.value.data?.user?.fullName ?? '';
        emailController.text = userResponseModel.value.data?.user?.email ?? '';
        mobileNumberTextController.text = userResponseModel.value.data?.user?.phoneNumber ?? '';
        genderController.text = userResponseModel.value.data?.user?.gender ?? '';
        final countryList = countries.where((country) => country.dialCode == userResponseModel.value.data?.user?.countryCode?.replaceAll("+", "")).toList();
        print(countryList); // For debugging, will print the list of matching countries
        selectedCountry.value = countryList.isNotEmpty
            ? countryList.first
            : countries.firstWhere((item) => item.code == 'GB', orElse: () => countries.first);
      }
    } catch (e, stackTrace) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  void skipPage() {
    // Implement navigation logic here
    // Example: Get.to(() => NextScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    emailFocusNode.dispose();
    referralCodeController.dispose();
    referralCodeFocusNode.dispose();
    mobileNumberTextController.dispose();
    mobileNumberFocusNode.dispose();
    genderController.dispose();
    genderFocusNode.dispose();
    super.onClose();
  }
}