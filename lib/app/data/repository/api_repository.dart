/*
 * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 * @author     : Gaurav Negi
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Henceforth Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */


import 'package:OLIVERS/app/modules/AuthModule/models/responsemodels/userResponseModel.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../export.dart';

import '../../modules/homeScreens/models/responseModels/HomeResponseModel.dart';
import '../../modules/homeScreens/models/responseModels/ResturantsResponseModel.dart';
import 'dio_client.dart';
import 'endpoint.dart';
import 'network_exceptions.dart' show NetworkExceptions;

class Repository {
  static late DioClient? dioClient;
  var deviceName, deviceType, deviceID, deviceVersion;

  Repository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = "ANDROID"; /* androidDeviceInfo.model;*/
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.systemName;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }

  /*===================================================================== Register API Call  ==========================================================*/
  Future signupApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(signUpEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future SignupOtpVerifyApi(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(signupVerifyOtp,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ForgetOtpVerifyApi(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(forgetOtpVerifyApiEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future HomeApi({query}) async {
    try {
      final response = await dioClient!.get(HomeApiEndPoint,skipAuth: false,queryParameters: query);
      return HomeResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future GetAllResturantsApi({query}) async {
    try {
      final response = await dioClient!.get(GetAllResturantsEndPoint,skipAuth: false,queryParameters: query);
      return ResturantsResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }




  Future ChangePasswordApi(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.patch(changePasswordEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future LoginApi(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(loginApiEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ForgetPasswordApi(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(forgetPasswordApiEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ResendOtpApi(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(ResendOtpApiEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future LogOutApi() async {
    try {
      final response = await dioClient!.post(logoutApiEndPoint, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


}
