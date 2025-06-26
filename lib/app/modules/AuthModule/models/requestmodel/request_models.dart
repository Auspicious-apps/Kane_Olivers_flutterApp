class AuthRequestModel {
/*===================================================Register Request Model==============================================*/
  static SignupRequestModel({
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    String? countryCode,
    String? gender,
    String? fcmToken,
    String? referalCode,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fullName"] = fullName;
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;
    data["countryCode"] = countryCode;
    data["password"] = password;
    data["gender"] = gender;
    data["fcmToken"] = fcmToken;
    data["referralCodeSignup"] = referalCode;
    return data;
  }


  static verifyOtpRequestModel({
    String? otp
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["otp"] = otp;

    return data;
  }

  static PasswordChangeRequestModel({

    String? password,
    String? oldPassword,
    String? newPassword,
    String? otp
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["password"] = password;
    data["otp"] = otp;
    data["oldPassword"] = oldPassword;
    data["newPassword"] = newPassword;
    return data;
  }


  static forgetPasswordRequestModel({
    String? email,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    return data;
  }

  static loginRequestModel({
    String? email,
    String? password,
    String? fcmToken,


  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    data["fcmToken"] = fcmToken;
    return data;
  }
}
