import 'abstract_outfit_class.dart';
import 'product_abstrct_class.dart';
import 'review_class.dart';
import 'specification_class.dart';

class DummyDatabase {
  // Helper method to generate product images for a category
  static List<Map<String, dynamic>> _generateProducts() {
    final categories = {
      "jacket": {"count": 6, "extension": "webp"},
      "jean": {"count": 7, "extension": "jpg"},
      "shirt": {"count": 15, "extension": "webp"},
      "shoe": {"count": 6, "extension": "webp"},
      "sportwear": {"count": 6, "extension": "webp"},
      "suit": {"count": 7, "extension": "jpg"},
    };

    int productId = 1; // Starting product ID
    List<Map<String, dynamic>> productData = [];

    categories.forEach((category, data) {
      final count = data["count"] as int; // Explicitly cast to int
      final extension = data["extension"] as String; // Explicitly cast to String

      for (int i = 1; i <= count; i++) {
        productData.add({
          "id": productId++,
          "image": "assets/images/${category} ($i).$extension",
          "category": category,
          "price": (1500.0 + productId * 50) % 10000, // Random price logic
          "isLiked": productId % 2 == 0, // Alternate like state
          "description": "High-quality ${category.capitalize()} $i.",
          "variation": [
            "assets/images/${category} ($i).$extension",
            "assets/images/${category} ($i).$extension",
          ], // Single image as variation
          "specification": {
            "materials": ["Cotton 95%", "Polyester 5%"],
            "origin": "Algeria",
            "sizes": ["S", "M", "L", "XL"],
            "colors": ["Red", "Black", "White", "Blue"],
          },
          "totalRatings": 4 + (productId % 5) * 0.1, // Slightly varied ratings
          "reviews": [
            {
              "username": "User${productId}",
              "rating": 4.5,
              "comment": "Great product, highly recommend!",
            },
            {
              "username": "Customer${productId}",
              "rating": 4.0,
              "comment": "Good quality, worth the price.",
            },
          ],
        });
      }
    });

    return productData;
  }


  // Map of Products
  static final List<Map<String, dynamic>> _productData = _generateProducts();

  // Map of Outfits
  static final List<Map<String, dynamic>> _outfitData = List.generate(8, (i) {
    return {
      "id": i + 1,
      "outfitImage": "assets/images/outfit (${i + 1}).jpg",
      "numOfLikes": (i + 1) * 50,
      "isLiked": i % 2 == 1, // Alternate like state
      "description": "Outfit description for outfit ${i + 1}",
      "outfitComponents": List.generate(
          3, (index) => (i * 3 + index) % _productData.length + 1), // Random products
    };
  });

  // Fetch list of products
  static List<Product> getProducts() {
    return _productData.map((data) {
      final spec = data["specification"];
      return _ProductImpl(
        id: data["id"],
        image: data["image"],
        category: data["category"],
        price: data["price"],
        isLiked: data["isLiked"],
        description: data["description"],
        variation: List<String>.from(data["variation"]),
        specification: Specification(
          materials: List<String>.from(spec["materials"]),
          origin: spec["origin"],
          sizes: List<String>.from(spec["sizes"]),
          colors: List<String>.from(spec["colors"]),
        ),
        totalRatings: data["totalRatings"],
        reviews: List<Review>.from(
          data["reviews"].map(
                (review) => Review(
              username: review["username"],
              rating: review["rating"],
              comment: review["comment"],
            ),
          ),
        ),
      );
    }).toList();
  }

  // Fetch list of outfits
  static List<Outfit> getOutfits() {
    return _outfitData.map((data) {
      return _OutfitImpl(
        id: data["id"],
        outfitImage: data["outfitImage"],
        numOfLikes: data["numOfLikes"],
        isLiked: data["isLiked"],
        description: data["description"],
        outfitComponents: List<int>.from(data["outfitComponents"]),
      );
    }).toList();
  }
}

// Private implementation of Product
class _ProductImpl extends Product {
  _ProductImpl({
    required super.id,
    required super.image,
    required super.category,
    required super.price,
    required super.isLiked,
    required super.description,
    required super.variation,
    required super.specification,
    required super.totalRatings,
    required super.reviews,
  });
}

// Private implementation of Outfit
class _OutfitImpl extends Outfit {
  _OutfitImpl({
    required super.id,
    required super.outfitImage,
    required super.numOfLikes,
    required super.isLiked,
    required super.description,
    required super.outfitComponents,
  });
}

// Extension to capitalize category names
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}