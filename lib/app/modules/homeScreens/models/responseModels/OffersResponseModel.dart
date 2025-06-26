import 'HomeResponseModel.dart';
import 'ResturantsResponseModel.dart';

class OffersResponseModel {
  bool? success;
  String? message;
  OfferData? data;

  OffersResponseModel({this.success, this.message, this.data});

  OffersResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new OfferData.fromJson(json['data']) : null;
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

class OfferData {
  List<RestaurantOffers>? restaurantOffers;


  OfferData({this.restaurantOffers});

  OfferData.fromJson(Map<String, dynamic> json) {
    if (json['restaurantOffers'] != null) {
      restaurantOffers = <RestaurantOffers>[];
      json['restaurantOffers'].forEach((v) {
        restaurantOffers!.add(new RestaurantOffers.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurantOffers != null) {
      data['restaurantOffers'] =
          this.restaurantOffers!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class RestaurantOffers {
  String? sId;
  String? offerName;
  String? image;
  String? description;
  num? visits;
  RestaurantId? restaurantId;


  RestaurantOffers(
      {this.sId, this.offerName, this.image, this.description, this.visits,  this.restaurantId,});

  RestaurantOffers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    offerName = json['offerName'];
    image = json['image'];
    description = json['description'];
    visits = json['visits'];
    restaurantId = json['restaurantId'] != null
        ? new RestaurantId.fromJson(json['restaurantId'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['offerName'] = this.offerName;
    data['image'] = this.image;
    data['description'] = this.description;
    data['visits'] = this.visits;
    if (this.restaurantId != null) {
      data['restaurantId'] = this.restaurantId!.toJson();
    }
    return data;
  }
}