import 'HomeResponseModel.dart';

class OffersDetailResponseModel {
  bool? success;
  String? message;
  OffersDetailData? data;

  OffersDetailResponseModel({this.success, this.message, this.data});

  OffersDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new OffersDetailData.fromJson(json['data']) : null;
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

class OffersDetailData {
  String? sId;
  RestaurantId? restaurantId;
  String? offerName;
  String? image;
  String? description;
  num? visits;
  String? redeemInStore;
  String? unlockRewards;
  String? identifier;
  num? iV;
  String? createdAt;
  String? updatedAt;

  OffersDetailData(
      {this.sId,
        this.restaurantId,
        this.offerName,
        this.image,
        this.description,
        this.visits,
        this.redeemInStore,
        this.unlockRewards,
        this.identifier,
        this.iV,
        this.createdAt,
        this.updatedAt});

  OffersDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    restaurantId = json['restaurantId'] != null
        ? new RestaurantId.fromJson(json['restaurantId'])
        : null;
    offerName = json['offerName'];
    image = json['image'];
    description = json['description'];
    visits = json['visits'];
    redeemInStore = json['redeemInStore'];
    unlockRewards = json['unlockRewards'];
    identifier = json['identifier'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.restaurantId != null) {
      data['restaurantId'] = this.restaurantId!.toJson();
    }
    data['offerName'] = this.offerName;
    data['image'] = this.image;
    data['description'] = this.description;
    data['visits'] = this.visits;
    data['redeemInStore'] = this.redeemInStore;
    data['unlockRewards'] = this.unlockRewards;
    data['identifier'] = this.identifier;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

