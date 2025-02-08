import 'dart:io';

class Shop {
  final int id;
  final String name;
  final String location;
  final int productsNum;
  final int followersNum;
  final bool isFollowed;
  final File shopImage;
  final double long;
  final double lat;

  Shop({
    required this.id,
    required this.name,
    required this.location,
    required this.productsNum,
    required this.followersNum,
    required this.isFollowed,
    required this.shopImage,
    required this.long,
    required this.lat,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      productsNum: json['productsNum'],
      followersNum: json['followersNum'],
      isFollowed: json['isFollowed'] == 1,
      shopImage: json['shopImage'],
      long: 0,
      lat: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'productsNum': productsNum,
      'followersNum': followersNum,
      'isFollowed': isFollowed ? 1 : 0,
      'shopImage': shopImage,
      'long': long,
      'lat': lat,
    };
  }

  Shop copyWith({
    int? id,
    String? name,
    String? location,
    int? productsNum,
    int? followersNum,
    bool? isFollowed,
    File? shopImage,
    double? long,
    double? lat,
  }) {
    return Shop(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      productsNum: productsNum ?? this.productsNum,
      followersNum: followersNum ?? this.followersNum,
      isFollowed: isFollowed ?? this.isFollowed,
      shopImage: shopImage ?? this.shopImage,
      long: long ?? this.long,
      lat: lat ?? this.lat,
    );
  }
}
