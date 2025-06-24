

import 'dart:convert';

import 'package:OLIVERS/app/modules/AuthModule/models/responsemodels/userResponseModel.dart';

import '../../../main.dart';

class PreferenceManager {
  static const String isFirstLaunch = "isFirstLaunch";
  static const String authToken = "authToken";
  static const String roleId = "roleId";
  static const String changeLanguage = "changeLanguage";
  static const String loginDataModel = "loginDataModel";
  static const String rememberMe = "rememberMe";
  static const String isNotificationOn = "isNotificationOn";
  static const String currentUserType = "currentUserType";
  static const String currentBottomNavIndex = "currentBottomNavIndex";
  static const String savedLocation = "savedLocation";
  static const String draftBookingData = "draftBookingData";
  static const String lastSavedRoute = "lastSavedRoute";
  static const String language = "language";
  static const String themeModeKey = 'themeMode';

  firstLaunch(bool? isFirstCheck) {
    localStorage
        .write(isFirstLaunch, isFirstCheck)
        .onError((error, stackTrace) {

      return false;
    });
    localStorage.read(
      isFirstLaunch,
    );
  }

  saveAuthToken(String? token) {
    if (token != null) {
      localStorage.write(authToken, token);
    }
  }

  getAuthToken() {
    return localStorage.read(authToken);
  }

  saveRole(int? role) {
    localStorage.write(roleId, role);
  }

  void saveThemeModeData(int themeMode) {
    localStorage.write(themeModeKey, themeMode);
  }

  Future<int> getThemeModeData() async {
    return localStorage.read(themeModeKey) ?? 0;
  }

  getRole() {
    return localStorage.read(roleId);
  }

  getStatusFirstLaunch() {
    return localStorage.read(isFirstLaunch) ?? false;
  }

  saveRegisterData(UserResponseModel? model) async {
    if (model != null) {
      localStorage.write(loginDataModel, jsonEncode(model));
    }
  }

  getSavedLoginData() async {
    Map<String, dynamic>? userMap;
    final userStr = await localStorage.read(loginDataModel);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    if (userMap != null) {
      UserResponseModel user = UserResponseModel.fromJson(userMap);
      return user;
    }
    return null;
  }

  Future getSaveRememberData() async {
    Map<String, dynamic>? userMap;
    final userStr = await localStorage.read(rememberMe);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    if (userMap != null) {
      // RememberMeModel user = RememberMeModel.fromJson(userMap);
      // return user;
    }
    return null;
  }

  // saveRememberMeData(RememberMeModel? model) async {
  //   localStorage.write(rememberMe, jsonEncode(model));
  // }

  clearRememberMeData() {
    localStorage.remove(rememberMe);
  }

  clearLoginData() {
    localStorage.remove(authToken);
    localStorage.remove(loginDataModel);
    localStorage.remove(isNotificationOn);
    localStorage.remove(currentUserType);
    localStorage.remove(currentBottomNavIndex);
    localStorage.remove(draftBookingData);
  }

  saveNotification(bool? notify) {
    localStorage.write(isNotificationOn, notify);
  }

  getNotification() {
    return localStorage.read(isNotificationOn);
  }

  saveCurrentUserType(String type) {
    localStorage.write(currentUserType, type);
  }

  getCurrentUserType() {
    return localStorage.read(currentUserType);
  }

  saveCurrentBottomNavType(String type) {
    localStorage.write(currentBottomNavIndex, type);
  }

  getCurrentBottomType() {
    return localStorage.read(currentBottomNavIndex);
  }

  // saveAddress(AddressDataModel? model) async {
  //   localStorage.write(savedLocation, jsonEncode(model));
  // }

  getSavedAddress() async {
    Map<String, dynamic>? addressMap;
    final userStr = await localStorage.read(savedLocation);
    if (userStr != null) {
      addressMap = jsonDecode(userStr) as Map<String, dynamic>;
    }
    // if (addressMap != null) {
    //   AddressDataModel addressDataModel = AddressDataModel.fromJson(addressMap);
    //   return addressDataModel;
    // }
    return null;
  }

  clearDraftBookingData() async {
    localStorage.remove(draftBookingData);
    localStorage.remove(lastSavedRoute);
  }

  saveCurrentRoute(String route) {
    localStorage.write(lastSavedRoute, route);
  }

  getLastSavedRoute() {
    return localStorage.read(lastSavedRoute);
  }

  saveLanguage(String? lang) {
    localStorage.write(language, lang);
  }

  getLanguage() {
    return localStorage.read(language);
  }
}
