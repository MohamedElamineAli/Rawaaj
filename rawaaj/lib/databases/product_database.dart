import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductDatabase {
  static final ProductDatabase instance = ProductDatabase._init();

  static Database? _database;

  ProductDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
    CREATE TABLE products (
      id $idType,
      image $textType,
      category $textType,
      price $doubleType,
      isLiked $boolType,
      description $textType,
      variation $textType,
      totalRatings $doubleType,
      reviews $textType,
      materials $textType,
      origin $textType,
      sizes $textType,
      colors $textType
    )
    ''');
  }

  // Future<int> createProduct(Product product) async {
  //   final db = await instance.database;
  //
  //   return await db.insert(
  //     'products',
  //     product.toMapForDB(),
  //   );
  // }
  //
  // Future<Product?> readProduct(int id) async {
  //   final db = await instance.database;
  //
  //   final maps = await db.query(
  //     'products',
  //     columns: null,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  //
  //   if (maps.isNotEmpty) {
  //     return Product.fromJson(maps.first);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<List<Product>> readAllProducts() async {
  //   final db = await instance.database;
  //
  //   final result = await db.query('products');
  //
  //   return result.map((json) => Product.fromMap(map: json, )).toList();
  // }

  // Future<int> updateProduct(Product product) async {
  //   final db = await instance.database;
  //
  //   return db.update(
  //     'products',
  //     product.toMapForDB(),
  //     where: 'id = ?',
  //     whereArgs: [product.id],
  //   );
  // }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;

    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}