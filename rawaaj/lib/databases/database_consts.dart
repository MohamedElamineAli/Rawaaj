import 'dart:io';

import '../models/product_model.dart';
import '../models/review_model.dart';
import '../services/outfit_services.dart';
import '../services/product_service.dart';
import '../services/user_account_service.dart';
import 'dummy_database.dart';
import 'product_database.dart';
import 'dart:math';
// import 'app_database.dart';
import '../models/shop_model.dart';
import '../models/outfit_model.dart';

final products = DummyDatabase.getProducts();
final outfits = DummyDatabase.getOutfits();

Future<void> initializeDatabase() async {
  // final db = AppDatabase.instance;

  // Shop data
  final List<String> shopImages = [
    'assets/images/shop1.jpg',
    'assets/images/shop2.jpg',
    'assets/images/shop3.jpg',
    'assets/images/shop4.jpg',
    'assets/images/shop5.jpg',
  ];

  // final supabase = SupabaseService().client;
  // final userAccountService = UserAccountService(supabase);
  //
  // for (int i=1; i<6; i++) {
  //   await userAccountService.addShopAccount(
  //   username: 'username_$i',
  //   email: 'email$i@ggg.ccc',
  //   password: 'password$i',
  //   userImage: shopImages[i-1],
  //   latitude: 0,
  //   longitude: 0,
  //   shopName: 'shop name $i',
  //   phoneNumber: '052369874$i',
  // );
  // }

  // final List<Shop> shops = List.generate(
  //   shopImages.length,
  //   (index) => Shop(
  //     id: index + 1,
  //     name: 'Shop ${index + 1}',
  //     location: 'Location ${index + 1}',
  //     productsNum: Random().nextInt(50) + 10,
  //     followersNum: Random().nextInt(1000) + 100,
  //     isFollowed: Random().nextBool(),
  //     shopImage: shopImages[index],
  //   ),
  // );

  // Insert shops
  // for (var shop in shops) {
  //   await db.insertShop(shop);
  // }

  List<String> categories = [
    "Jackets",
    "Jeans",
    "Shirts",
    "Shoes",
    "Sportswear",
    "Suits",
  ];

  // for(var category in categories) {
  //   await db.insertCategory(category);
  // }

  // Reviews
  final List<Review> reviews = [
    Review(username: "Ahmad", rating: 4.5, comment: "Excellent product!"),
    Review(username: "Amine", rating: 4.0, comment: "Good quality"),
    Review(username: "Jamal", rating: 3.5, comment: "Average experience"),
  ];

  // Product data
  final List<Product> newProducts = List.generate(products.length, (index) {
    var product = products[index];

    // Generate unique random sizes and colors
    int sizeCount = Random().nextInt(6) + 1; // Number of sizes (1 to 6)
    int colorCount = Random().nextInt(7) + 1; // Number of colors (1 to 7)

    // Use Set to ensure uniqueness
    Set<int> sizesSet = {};
    Set<int> colorsSet = {};
    while (sizesSet.length < sizeCount) {
      sizesSet.add(Random().nextInt(6) + 1); // Sizes range from 1 to 6
    }
    while (colorsSet.length < colorCount) {
      colorsSet.add(Random().nextInt(7) + 1); // Colors range from 1 to 7
    }

    // Convert Sets back to Lists
    List<int> sizes = sizesSet.toList();
    List<int> colors = colorsSet.toList();

    return Product(
      id: product.id,
      images: [File(product.image)],
      categoryId: product.category,
      price: (Random().nextDouble() * 200 + 100).toInt() * 10,
      isLiked: Random().nextBool(),
      description: product.description,
      variation: product.variation,
      totalRatings: product.totalRatings,
      reviews: reviews,
      materials: ["Cotton 95%", "Nylon 5%"],
      origin: "EU",
      sizes: sizes,
      colors: colors,
      shopId: product.id % 5 + 1,
    );
  });


  var productContexts = ["history", "top", "new", "just_for_you"];

  // for(int i=0;i < newProducts.length; i++) {
  //   await db.insertProduct(newProducts[i], productContexts[i%4]);
  // }

  final productService = ProductService();

  for(final product in newProducts) {
    await productService.addProduct(product);
  }

  // Outfit data
  final List<Outfit> newOutfits = List.generate(
    outfits.length,
    (index) {
      var outfit = outfits[index];
      return Outfit(
        id: outfit.id,
        outfitImage: File(outfit.outfitImage),
        numOfLikes: Random().nextInt(500),
        isLiked: Random().nextBool(),
        description: 'Outfit description ${index + 1}',
        totalPrice: (Random().nextDouble() * 1600 + 400).toInt() * 10,
        outfitComponents: [5, 30, 4, 15],
      );
    },
  );

  final outfitService = OutfitService();
  for(final outfit in newOutfits) {
    await outfitService.addOutfit(outfit);
  }

  var outfitContexts = ["history", "just_for_you"];

  // for(int i=0;i < newOutfits.length; i++) {
  //   await db.insertOutfit(newOutfits[i], outfitContexts[i%2]);
  // }

  print('Database initialized with shops, products, and outfits.');
}
