import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/outfit_model.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';
import '../models/shop_model.dart';
import '../models/summarized_outfit_model.dart';
import '../models/summarized_product_model.dart';
import '../models/summarized_shop_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE shops (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        location TEXT NOT NULL,
        productsNum INTEGER NOT NULL,
        followersNum INTEGER NOT NULL,
        isFollowed BOOLEAN NOT NULL,
        shopImage TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        price REAL NOT NULL,
        isLiked BOOLEAN NOT NULL,
        description TEXT NOT NULL,
        totalRatings REAL NOT NULL,
        materials TEXT NOT NULL, -- Consider normalizing this as well
        origin TEXT NOT NULL,
        product_context_type TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE outfits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        outfitImage TEXT NOT NULL,
        total_price REAL NOT NULL,
        numOfLikes INTEGER NOT NULL,
        isLiked BOOLEAN NOT NULL,
        description TEXT NOT NULL,
        outfit_context_type TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE reviews (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        rating REAL NOT NULL,
        comment TEXT NOT NULL,
        product_id INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE colors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE sizes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE product_colors (
        product_id INTEGER NOT NULL,
        color_id INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
        FOREIGN KEY (color_id) REFERENCES colors (id) ON DELETE CASCADE,
        PRIMARY KEY (product_id, color_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE product_sizes (
        product_id INTEGER NOT NULL,
        size_id INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
        FOREIGN KEY (size_id) REFERENCES sizes (id) ON DELETE CASCADE,
        PRIMARY KEY (product_id, size_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE
      );
    ''');

    await db.execute('''
      CREATE TABLE product_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        link TEXT NOT NULL,
        product_id INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE product_variations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        product_id INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
      );
    ''');
  }

  Future<int> insertShop(Shop shop) async {
    final db = await instance.database;
    return await db.insert('shops', shop.toJson());
  }

  Future<int> insertProduct(
      Product product, String productContextType) async {
    final db = await instance.database;

    int productId =
        await db.insert('products', product.toJson(productContextType));

    for (final sizeId in product.sizes) {
      await db.insert('product_sizes', {
        'product_id': productId,
        'size_id': sizeId,
      });
    }

    for (final colorId in product.colors) {
      await db.insert('product_colors', {
        'product_id': productId,
        'color_id': colorId,
      });
    }

    for (final imageLink in product.images) {
      await db.insert('product_images', {
        'link': imageLink,
        'product_id': productId,
      });
    }

    for (final variation in product.variation) {
      await db.insert('product_variations', {
        'name': variation,
        'product_id': productId,
      });
    }

    for (final review in product.reviews) {
      await insertReview(review, productId);
    }

    return productId;
  }

  Future<int> insertOutfit(Outfit outfit, String outfitContextType) async {
    final db = await instance.database;
    return await db.insert('outfits', outfit.toJson(outfitContextType));
  }

  Future<int> insertReview(Review review, int productId) async {
    final db = await instance.database;
    return await db.insert('reviews', {
      'username': review.username,
      'rating': review.rating,
      'comment': review.comment,
      'product_id': productId,
    });
  }

  Future<int> insertCategory(String name) async {
    final db = await instance.database;
    return await db.insert('categories', {'name': name});
  }

  Future<Shop?> getShopById(int id) async {
    final db = await instance.database;
    final results = await db.query(
      'shops',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? Shop.fromJson(results.first) : null;
  }

  Future<String?> getCategoryById(int id) async {
    final db = await instance.database;
    final results = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first['name'] as String : null;
  }

  Future<Product?> getProductById(int id) async {
    final db = await instance.database;

    // Fetch main product details
    final results = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) return null; // Product not found

    final productMap = results.first;

    // Fetch related data
    final sizes = await _getSizesForProduct(id);
    final colors = await _getColorsForProduct(id);
    final images = await _getImagesForProduct(id);
    final variations = await _getVariationsForProduct(id);
    final reviews = await _getReviewsForProduct(id);
    final imageFiles = await Future.wait(images.map((path) => getFileFromAsset(path)));


    return Product.fromJson(
      map: productMap,
      sizes: sizes,
      colors: colors,
      images: imageFiles,
      variations: variations,
      reviews: reviews,
    );
  }

  Future<List<int>> _getSizesForProduct(int productId) async {
    final db = await instance.database;
    final results = await db.rawQuery('''
    SELECT s.id
    FROM sizes s
    JOIN product_sizes ps ON s.id = ps.size_id
    WHERE ps.product_id = ?
  ''', [productId]);
    return results.map((map) => map['id'] as int).toList();
  }

  Future<List<int>> _getColorsForProduct(int productId) async {
    final db = await instance.database;
    final results = await db.rawQuery('''
    SELECT c.id
    FROM colors c
    JOIN product_colors pc ON c.id = pc.color_id
    WHERE pc.product_id = ?
  ''', [productId]);
    return results.map((map) => map['id'] as int).toList();
  }

  Future<List<String>> _getImagesForProduct(int productId) async {
    final db = await instance.database;
    final results = await db.query(
      'product_images',
      where: 'product_id = ?',
      whereArgs: [productId],
      columns: ['link'],
    );
    return results.map((map) => map['link'] as String).toList();
  }

  Future<List<String>> _getVariationsForProduct(int productId) async {
    final db = await instance.database;
    final results = await db.query(
      'product_variations',
      where: 'product_id = ?',
      whereArgs: [productId],
      columns: ['name'],
    );
    return results.map((map) => map['name'] as String).toList();
  }

  Future<List<Review>> _getReviewsForProduct(int productId) async {
    final db = await instance.database;
    final results = await db.query(
      'reviews',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    return results.map((map) => Review.fromJson(map)).toList();
  }

  Future<Outfit?> getOutfitById(int id) async {
    final db = await instance.database;
    final results = await db.query(
      'outfits',
      where: 'id = ?',
      whereArgs: [id],
    );
    var result = Map<String, dynamic>.from(results.first);
    result['outfitImage'] = await getFileFromAsset(result['outfitImage'] as String);
    var outfit = results.isNotEmpty ? Outfit.fromJson(result) : null;
    return outfit;
  }

  Future<Review?> getReviewById(int id) async {
    final db = await instance.database;
    final results = await db.query(
      'reviews',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? Review.fromJson(results.first) : null;
  }

  Future<List<SummarizedShop>> getAllShops() async {
    final db = await instance.database;
    final results = await db.query('shops',
        columns: ['id', 'shopImage']); // Select only relevant columns

    print(results);
    return results.map((json) => SummarizedShop.fromJson(json)).toList();
  }

  Future<List<SummarizedProduct>> getAllProducts() async {
    final db = await instance.database;

    final results = await db.rawQuery('''
    SELECT 
      p.id, 
      pi.link AS image, 
      p.price, 
      p.description,
      p.isLiked
    FROM products p
    LEFT JOIN product_images pi ON p.id = pi.product_id
    GROUP BY p.id
  ''');

    return results.map((json) => SummarizedProduct.fromJson(json)).toList();
  }

  Future<List<SummarizedOutfit>> getAllOutfits() async {
    final db = await instance.database;
    final results = await db.query(
        'outfits');
    return results.map((json) => SummarizedOutfit.fromJson(json)).toList();
  }

  Future<List<Review>> getAllReviews() async {
    final db = await instance.database;
    final results = await db.query('reviews');
    return results.map((json) => Review.fromJson(json)).toList();
  }

  Future<List<String>> getAllCategories() async {
    final db = await instance.database;
    final results = await db.query('categories', columns: ['name']);
    return results.map((map) => map['name'] as String).toList();
  }

  Future<List<Review>> getReviewsByProductId(int productId) async {
    final db = await instance.database;
    final results = await db.query(
      'reviews',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    return results.map((json) => Review.fromJson(json)).toList();
  }

  Future<List<SummarizedProduct>> getProductsByContextType(String contextType) async {
    final db = await instance.database;

    final results = await db.rawQuery('''
    SELECT 
      p.id, 
      pi.link AS image, 
      p.price, 
      p.description,
      p.isLiked
    FROM products p
    LEFT JOIN product_images pi ON p.id = pi.product_id
    WHERE p.product_context_type = ?
    GROUP BY p.id
  ''', [contextType]);

    return results.map((productMap) => SummarizedProduct.fromJson(productMap)).toList();
  }

  Future<List<SummarizedProduct>> getProductsByCategoryId(int categoryId) async {
    final db = await instance.database;

    final results = await db.rawQuery('''
    SELECT 
      p.id, 
      pi.link AS image, 
      p.price, 
      p.description,
      p.isLiked
    FROM products p
    LEFT JOIN product_images pi ON p.id = pi.product_id
    WHERE p.category_id = ?
    GROUP BY p.id
  ''', [categoryId]);

    return results.map((productMap) => SummarizedProduct.fromJson(productMap)).toList();
  }


  Future<List<SummarizedOutfit>> getOutfitsByContextType(
      String contextType) async {
    final db = await instance.database;
    final results = await db.query('outfits',
        where: 'outfit_context_type = ?',
        whereArgs: [contextType],
        columns: ['id', 'outfitImage', 'numOfLikes', 'isLiked', 'total_price']);

    return results
        .map((outfitMap) => SummarizedOutfit.fromJson(outfitMap))
        .toList();
  }

  Future<void> toggleProductLike(int productId) async {
    final db = await instance.database;

    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
      columns: ['isLiked'],
    );

    if (result.isNotEmpty) {
      final currentIsLiked = result.first['isLiked'] as int;

      await db.update(
        'products',
        {'isLiked': currentIsLiked == 0 ? 1 : 0},
        where: 'id = ?',
        whereArgs: [productId],
      );
    }
  }

  Future<void> toggleOutfitLike(int outfitId) async {
    final db = await instance.database;

    final result = await db.query(
      'outfits',
      where: 'id = ?',
      whereArgs: [outfitId],
      columns: ['isLiked'],
    );

    if (result.isNotEmpty) {
      final currentIsLiked = result.first['isLiked'] as int;

      await db.update(
        'outfits',
        {'isLiked': currentIsLiked == 0 ? 1 : 0},
        where: 'id = ?',
        whereArgs: [outfitId],
      );
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<File> getFileFromAsset(String assetPath) async {
    // Load the asset as bytes
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List bytes = byteData.buffer.asUint8List();

    // Get a temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/${assetPath.split('/').last}';

    // Write the bytes to a file
    File file = File(tempPath);
    await file.writeAsBytes(bytes);

    return file;
  }
}
