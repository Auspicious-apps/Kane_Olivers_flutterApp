class HomeResponseModel {
  bool? success;
  HomeData? data;

  HomeResponseModel({this.success, this.data});

  HomeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeData {
  String? userName;
  num? totalPoints;
  List<PopularRestaurants>? popularRestaurants;
  List<OffersAvailable>? offersAvailable;

  HomeData(
      {this.userName,
        this.totalPoints,
        this.popularRestaurants,
        this.offersAvailable});

  HomeData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    totalPoints = json['totalPoints'];
    if (json['popularRestaurants'] != null) {
      popularRestaurants = <PopularRestaurants>[];
      json['popularRestaurants'].forEach((v) {
        popularRestaurants!.add(new PopularRestaurants.fromJson(v));
      });
    }
    if (json['offersAvailable'] != null) {
      offersAvailable = <OffersAvailable>[];
      json['offersAvailable'].forEach((v) {
        offersAvailable!.add(new OffersAvailable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['totalPoints'] = this.totalPoints;
    if (this.popularRestaurants != null) {
      data['popularRestaurants'] =
          this.popularRestaurants!.map((v) => v.toJson()).toList();
    }
    if (this.offersAvailable != null) {
      data['offersAvailable'] =
          this.offersAvailable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopularRestaurants {
  String? sId;
  String? restaurantName;
  String? image;
  bool? isDeleted;
  String? identifier;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PopularRestaurants(
      {this.sId,
        this.restaurantName,
        this.image,
        this.isDeleted,
        this.identifier,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PopularRestaurants.fromJson(Map<String, dynamic> json) {
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

class OffersAvailable {
  String? sId;
  RestaurantId? restaurantId;
  String? offerName;
  String? image;
  String? description;
  num? visits;
  String? redeemInStore;
  String? unlockRewards;
  String? identifier;
  int? iV;
  String? createdAt;
  String? updatedAt;

  OffersAvailable(
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

  OffersAvailable.fromJson(Map<String, dynamic> json) {
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
class RestaurantId {
  String? sId;
  String? restaurantName;
  String? image;
  bool? isDeleted;
  String? identifier;
  String? createdAt;
  String? updatedAt;
  int? iV;

  RestaurantId(
      {this.sId,
        this.restaurantName,
        this.image,
        this.isDeleted,
        this.identifier,
        this.createdAt,
        this.updatedAt,
        this.iV});

  RestaurantId.fromJson(Map<String, dynamic> json) {
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