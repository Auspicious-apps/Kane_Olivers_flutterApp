

import 'package:OLIVERS/app/data/local/preferences/preference.dart';
import 'package:OLIVERS/app/export.dart';


import '../widgets/onboarding_item.dart';
import '/app/core/base/base_controller.dart';

class OnBoardingController extends BaseController {
  RxList<OnBoardingItem> listItem = RxList.empty();
  RxInt selectedIndex = 0.obs;
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  Rx<PageController> pageController = PageController(
    initialPage: 0,
  ).obs;


  @override
  void onInit() {
    _addData();
    super.onInit();
  }

  _addData() {
    listItem.clear();
    listItem.add( OnBoardingItem(
        image: onBoardingFirstImage,
        heading: "Welcome to Loyalty App",
        subheading: "Earn stamps, unlock perks, and climb the leaderboard with every visit."));
    listItem.add( OnBoardingItem(
        image: onBoardingSecondImage,
        heading: "Earn Stamps. Unlock Rewards.",
        subheading: "Earn stamps, unlock perks, and climb the leaderboard with every visit."));
    listItem.add( OnBoardingItem(
        image: onBoardingThirdImage,
        heading: "Level Up & Get Rewarded",
        subheading: "Track your journey, climb the leaderboard, and redeem in-store rewards — all in one app."));
  }

  void movePageController() {
    if (selectedIndex.value <= 1) {
      selectedIndex.value++;
      pageController.value.animateToPage(
          selectedIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut
      );
      pageController.refresh();
    } else {
      moveToSignUpPage();
    }
  }

  void prevPageController(){
    if (selectedIndex.value != 0) {
      selectedIndex.value--;
      pageController.value.animateToPage(
          selectedIndex.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut
      );
      pageController.refresh();
    }
  }

  void moveToSignUpPage(){
    _localStorage.saveFirstLaunch(false);
    Get.offAllNamed(AppRoutes.refferalScreen);

  }


  void skipPage() {
    _localStorage.saveFirstLaunch(false);
    Get.offAllNamed(AppRoutes.refferalScreen);
  }
}
