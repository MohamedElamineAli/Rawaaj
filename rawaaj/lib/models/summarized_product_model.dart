import 'dart:io';

class SummarizedProduct {
  final int id;
  final File image;
  final double price;
  final String description;
  final bool isLiked;


  SummarizedProduct({
    required this.id,
    required this.image,
    required this.price,
    required this.description,
    required this.isLiked
  });

  factory SummarizedProduct.fromJson(Map<String, dynamic> json) {
    return SummarizedProduct(
      id: json['id'],
      image: json['image'],
      price: json['price'].toDouble(),
      description: json['description'],
      isLiked: json['isLiked'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'price': price,
      'description': description,
      'isLiked': isLiked ? 1 : 0,
    };
  }

  SummarizedProduct copyWith({
    int? id,
    File? image,
    double? price,
    String? description,
    bool? isLiked
  }) {
    return SummarizedProduct(
      id: id ?? this.id,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  String getFormattedPrice() {
    return '${price.toStringAsFixed(2)} DZD';
  }
}
