class UserResponseModel {
  bool? success;
  String? message;
  Data? data;

  UserResponseModel({this.success, this.message, this.data});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  bool? isDeleted;
  String? sId;
  String? role;
  String? fullName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? gender;
  Null? referalCode;
  int? totalPoints;
  int? redeemedPoints;
  int? activePoints;
  bool? isVerified;
  bool? isBlocked;
  String? identifier;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.isDeleted,
        this.sId,
        this.role,
        this.fullName,
        this.email,
        this.countryCode,
        this.phoneNumber,
        this.gender,
        this.referalCode,
        this.totalPoints,
        this.redeemedPoints,
        this.activePoints,
        this.isVerified,
        this.isBlocked,
        this.identifier,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    role = json['role'];
    fullName = json['fullName'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    referalCode = json['referalCode'];
    totalPoints = json['totalPoints'];
    redeemedPoints = json['redeemedPoints'];
    activePoints = json['activePoints'];
    isVerified = json['isVerified'];
    isBlocked = json['isBlocked'];
    identifier = json['identifier'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['referalCode'] = this.referalCode;
    data['totalPoints'] = this.totalPoints;
    data['redeemedPoints'] = this.redeemedPoints;
    data['activePoints'] = this.activePoints;
    data['isVerified'] = this.isVerified;
    data['isBlocked'] = this.isBlocked;
    data['identifier'] = this.identifier;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}