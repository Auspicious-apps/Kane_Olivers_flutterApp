class ResturantsResponseModel {
  bool? success;
  String? message;
  RestaurantData? data;

  ResturantsResponseModel({this.success, this.message, this.data});

  ResturantsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new RestaurantData.fromJson(json['data']) : null;
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

class RestaurantData {
  List<Restaurants>? restaurants;
  num? page;
  num? limit;
  num? total;

  RestaurantData({this.restaurants, this.page, this.limit, this.total});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants!.add(new Restaurants.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    return data;
  }
}

class Restaurants {
  String? sId;
  String? restaurantName;
  String? image;
  bool? isDeleted;
  String? identifier;
  String? createdAt;
  String? updatedAt;
  num? iV;

  Restaurants(
      {this.sId,
        this.restaurantName,
        this.image,
        this.isDeleted,
        this.identifier,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Restaurants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    restaurantName = json['restaurantName'];
    image = json['image'];
    isDeleted = json['isDeleted'];
    identifier = json['identifier'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['restaurantName'] = this.restaurantName;
    data['image'] = this.image;
    data['isDeleted'] = this.isDeleted;
    data['identifier'] = this.identifier;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}