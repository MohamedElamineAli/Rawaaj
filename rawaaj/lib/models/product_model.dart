import 'dart:convert';
import 'dart:io';

import 'review_model.dart';

class Product {
  final int id;
  final List<File> images;
  final int categoryId;
  final double price;
  final bool isLiked;
  final String description;
  final List<String> variation; // witch is another products so it need inner many to many table of pro
  final double totalRatings;
  final List<Review> reviews;
  final List<String> materials;
  final String origin;
  final List<int> sizes;
  final List<int> colors;
  final int? shopId;
  // add product_context_type attribute if it is {history, top, new, just_for_you}

  Product({
    required this.id,
    required this.images,
    required this.categoryId,
    required this.price,
    required this.isLiked,
    required this.description,
    required this.variation,
    required this.totalRatings,
    required this.reviews,
    required this.materials,
    required this.origin,
    required this.sizes,
    required this.colors,
    this.shopId
  });

  Map<String, dynamic> toJson(productContextType) {
    return {
      'id': id,
      'category_id': categoryId,
      'price': price,
      'isLiked': isLiked ? 1 : 0,
      'description': description,
      'totalRatings': totalRatings,
      'materials': jsonEncode(materials),
      'origin': origin,
      'product_context_type': productContextType,
    };
  }

  static Product fromJson({required Map<String, dynamic> map, required List<int> sizes, required List<int> colors, required List<File> images, required List<String> variations, required List<Review> reviews}) {
    return Product(
      id: map['id'],
      images: images,
      categoryId: map['category_id'],
      price: map['price'],
      isLiked: map['isLiked'] == 1,
      description: map['description'],
      variation: variations,
      totalRatings: map['totalRatings'],
      reviews: reviews,
      materials: List<String>.from(jsonDecode(map['materials'])),
      origin: map['origin'],
      sizes: sizes,
      colors: colors,
      shopId: map['shop_id'],
    );
  }

  Product copyWith({
    int? id,
    List<File>? images,
    int? categoryId,
    double? price,
    bool? isLiked,
    String? description,
    List<String>? variation,
    double? totalRatings,
    List<Review>? reviews,
    List<String>? materials,
    String? origin,
    List<int>? sizes,
    List<int>? colors,
    int? shopId,
  }) {
    return Product(
      id: id ?? this.id,
      images: images ?? this.images,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      isLiked: isLiked ?? this.isLiked,
      description: description ?? this.description,
      variation: variation ?? this.variation,
      totalRatings: totalRatings ?? this.totalRatings,
      reviews: reviews ?? this.reviews,
      materials: materials ?? this.materials,
      origin: origin ?? this.origin,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      shopId: shopId ?? this.shopId,
    );
  }
}