/*
 * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 * @author     : Gaurav Negi
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Henceforth Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import 'package:get_storage/get_storage.dart';
import 'package:OLIVERS/app/core/base/socket_file.dart';
import 'app/data/repository/api_repository.dart';
import 'app/data/repository/prefrence_manager.dart';
import 'app/export.dart';
import 'my_app.dart';


// CustomLoader customLoader = CustomLoader();
GetStorage localStorage = GetStorage();
RxBool isDarkModeTheme=false.obs;
late Repository repository;
// SocketIOManager? socketIOManager;
late PreferenceManager preferenceManager;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();

  systemThemeMode();
  orientation();
  initApp();
}

void systemThemeMode() {
  // Get the current system brightness (light/dark mode)
  var window = WidgetsBinding.instance.window;
  var brightness = window.platformBrightness;

  // Set initial theme mode based on system's brightness
  isDarkModeTheme.value = brightness == Brightness.dark;

  // Update GetX theme based on system brightness
  Get.changeThemeMode(isDarkModeTheme.value ? ThemeMode.dark : ThemeMode.light);

  // Listen for changes in the platform's brightness
  window.onPlatformBrightnessChanged = () {
    var brightness = window.platformBrightness;
    // Update the theme mode when system theme changes
    isDarkModeTheme.value = brightness == Brightness.dark;

    // Change the theme based on new brightness
    Get.changeThemeMode(isDarkModeTheme.value ? ThemeMode.dark : ThemeMode.light);
    Get.forceAppUpdate();
  };
}


init() async {
  await GetStorage.init();
  repository = Get.put(Repository());
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

initApp() async {
  runApp( MyApp());
}

orientation() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor:
    Platform.isAndroid ? AppColors.appColor : Colors.transparent,
    systemNavigationBarContrastEnforced: true,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
