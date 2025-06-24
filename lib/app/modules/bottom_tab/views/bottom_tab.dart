

import 'package:OLIVERS/app/modules/dashboard/view/home_screen.dart';
import 'package:OLIVERS/app/modules/dashboard/view/setting_screen.dart';

import '../../../export.dart';
import '../controllers/bottom_tab_controller.dart';

class BottomTab extends StatelessWidget {
  List<Widget> screens = <Widget>[
    HomeScreen(),
    SettingScreen(),

  ];
  var controller=Get.put(BottomTabController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: _bodyWidget(),

        bottomNavigationBar: Obx(() => _bottomNavigator())
    );
  }

  Widget _bodyWidget()=>GetBuilder<BottomTabController>(
  init: BottomTabController(),
  builder: (context) {
    return Obx(() => screens.elementAt(controller.selectedIndex.value));
  });

  Widget _bottomNavigator() =>
      BottomNavigationBar(
        unselectedItemColor: AppColors.greyColor,
        selectedItemColor: AppColors.blackColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
         type: BottomNavigationBarType.fixed,
        currentIndex: controller.selectedIndex.value,
        onTap: (i) {
         controller.changeIndex(i);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          // BottomNavigationBarItem(
          //   icon: ImageIcon(AssetImage(iconsFood)),
          //   label: 'food',
          // ),
          // BottomNavigationBarItem(
          //   icon: ImageIcon(AssetImage(iconsProfile)),
          //   label: 'profile',
          // ),
        ],
      );
}