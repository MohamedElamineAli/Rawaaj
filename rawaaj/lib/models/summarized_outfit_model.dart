import 'dart:io';

class SummarizedOutfit {
  final int id;
  final File outfitImage;
  final int numOfLikes;
  final bool isLiked;
  final double totalPrice;

  SummarizedOutfit({
    required this.id,
    required this.outfitImage,
    required this.numOfLikes,
    required this.isLiked,
    required this.totalPrice,
  });

  factory SummarizedOutfit.fromJson(Map<String, dynamic> json) {
    return SummarizedOutfit(
      id: json['id'],
      outfitImage: json['outfitImage'],
      numOfLikes: json['numOfLikes'],
      isLiked: json['isLiked'] == 1, // i think there is problem here because the json is not bool
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'outfitImage': outfitImage,
      'numOfLikes': numOfLikes,
      'isLiked': isLiked ? 1 : 0,
      'totalPrice': totalPrice,
    };
  }

  SummarizedOutfit copyWith({
    int? id,
    File? outfitImage,
    int? numOfLikes,
    bool? isLiked,
    double? totalPrice,
  }) {
    return SummarizedOutfit(
      id: id ?? this.id,
      outfitImage: outfitImage ?? this.outfitImage,
      numOfLikes: numOfLikes ?? this.numOfLikes,
      isLiked: isLiked ?? this.isLiked,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
