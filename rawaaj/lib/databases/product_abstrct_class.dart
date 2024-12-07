import 'review_class.dart';
import 'specification_class.dart';

abstract class Product {
  final int id;
  final String image;
  final String category; // New category attribute
  final double price;
  final bool isLiked;
  final String description;
  final List<String> variation; // List of variations (image paths)
  final Specification specification;
  final double totalRatings; // Ratings out of 5
  final List<Review> reviews;

  Product({
    required this.id,
    required this.image,
    required this.category,
    required this.price,
    required this.isLiked,
    required this.description,
    required this.variation,
    required this.specification,
    required this.totalRatings,
    required this.reviews,
  });
}