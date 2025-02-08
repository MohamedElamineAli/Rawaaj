import 'dart:io';

class SummarizedShop {
  final int id;
  final File shopImage;

  SummarizedShop({required this.id, required this.shopImage});

  factory SummarizedShop.fromJson(Map<String, dynamic> json) {
    return SummarizedShop(
      id: json['id'],
      shopImage: json['shopImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopImage': shopImage,
    };
  }

  SummarizedShop copyWith({
    int? id,
    File? shopImage,
  }) {
    return SummarizedShop(
      id: id ?? this.id,
      shopImage: shopImage ?? this.shopImage,
    );
  }
}
