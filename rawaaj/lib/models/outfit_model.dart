import 'dart:io';

class Outfit {
  final int id;
  final File outfitImage;
  final int numOfLikes;
  final bool isLiked;
  final double totalPrice;
  final String description;
  final List<int>? outfitComponents; // Products
  // add outfit_context_type attribute if it is {history, just_for_you}

  Outfit({
    required this.id,
    required this.outfitImage,
    required this.numOfLikes,
    required this.isLiked,
    required this.description,
    required this.totalPrice,
    this.outfitComponents,
  });

  factory Outfit.fromJson(Map<String, dynamic> json) {
    return Outfit(
      id: json['id'],
      outfitImage: json['outfitImage'],
      numOfLikes: json['numOfLikes'],
      isLiked: json['isLiked'] == 1,
      description: json['description'],
      totalPrice: json['total_price']
    );
  }

  Map<String, dynamic> toJson(String outfitContextType) {
    return {
      'id': id,
      'outfitImage': outfitImage,
      'numOfLikes': numOfLikes,
      'isLiked': isLiked ? 1 : 0,
      'description': description,
      'total_price': totalPrice,
      'outfit_context_type': outfitContextType,
    };
  }

  Outfit copyWith({
    int? id,
    File? outfitImage,
    int? numOfLikes,
    bool? isLiked,
    String? description,
    double? totalPrice,
    List<int>? outfitComponents,
  }) {
    return Outfit(
      id: id ?? this.id,
      outfitImage: outfitImage ?? this.outfitImage,
      numOfLikes: numOfLikes ?? this.numOfLikes,
      isLiked: isLiked ?? this.isLiked,
      description: description ?? this.description,
      totalPrice: totalPrice ?? this.totalPrice,
      outfitComponents: outfitComponents ?? this.outfitComponents,
    );
  }
}
