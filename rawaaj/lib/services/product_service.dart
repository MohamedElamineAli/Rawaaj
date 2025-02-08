import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rawaaj/constants/service_url.dart';
import 'package:rawaaj/services/image_services.dart';
import '../models/product_model.dart';
import '../models/summarized_product_model.dart';

class ProductService {
  final String baseUrl = serviceUrl;
  final ImageService imageService = ImageService();

  Future<int?> addProduct(Product product) async {
    final imagesPath = await Future.wait(
        product.images.map((file) => imageService.uploadImage(file)));

    final response = await http.post(
      Uri.parse('$baseUrl/products/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'category_id': product.categoryId,
        'shop_id': product.shopId,
        'price': product.price,
        'description': product.description,
        'total_ratings': product.totalRatings,
        'materials': product.materials,
        'origin': product.origin,
        'sizes': product.sizes,
        'colors': product.colors,
        'images': imagesPath,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['product_id'];
    } else {
      throw Exception("Failed to add product");
    }
  }

  Future<Product?> getProductById(int productId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/product/?product_id=$productId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['product'];

      final images = await Future.wait((data['images'] as List<dynamic>).map(
        (imgUrl) => imageService.downloadImage(imgUrl),
      ));

      final imagesFile = [for (var image in images) image ?? File('')];

      return Product(
        id: data['id'],
        categoryId: data['category_id'],
        shopId: data['shop_id'],
        price: (data['price'] as num?)?.toDouble() ?? 0.0,
        description: data['description'],
        totalRatings: data['total_ratings'],
        materials: List<String>.from(data['materials']),
        origin: data['origin'],
        isLiked: data['is_liked'],
        images: imagesFile,
        variation: [],
        reviews: [],
        sizes: (data['sizes'] as List<dynamic>)
            .map((size) => size as int)
            .toList(),
        colors: (data['colors'] as List<dynamic>)
            .map((size) => size as int)
            .toList(),
      );
    } else {
      throw Exception("Failed to fetch product details");
    }
  }

  Future<List<SummarizedProduct>> getAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['products'];

      return await Future.wait(data.map((item) async => SummarizedProduct(
            id: item['id'],
            price: (item['price'] as num?)?.toDouble() ?? 0.0,
            description: item['description'],
            isLiked: item['is_liked'],
            image: await imageService.downloadImage(item['image']) ?? File(''),
          )));
    } else {
      throw Exception("Failed to fetch products");
    }
  }

  Future<List<SummarizedProduct>> getProductsByContextType(
      String contextType, int userId) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/products/context/?context_type=$contextType&user_id=$userId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['products'];
      return await Future.wait(data.map((item) async => SummarizedProduct(
            id: item['id'],
            price: (item['price'] as num?)?.toDouble() ?? 0.0,
            description: item['description'],
            isLiked: item['is_liked'],
            image: await imageService.downloadImage(item['image']) ?? File(''),
          )));
    } else {
      throw Exception("Failed to fetch products by context type");
    }
  }

  Future<List<SummarizedProduct>> searchProductsByDescription(
      String keyword) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/search/?keyword=$keyword'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['products'];
      return await Future.wait(data.map((item) async => SummarizedProduct(
            id: item['id'],
            price: (item['price'] as num?)?.toDouble() ?? 0.0,
            description: item['description'],
            isLiked: item['is_liked'],
            image: await imageService.downloadImage(item['image']) ?? File(''),
          )));
    } else {
      throw Exception("Failed to search products");
    }
  }

  Future<List<SummarizedProduct>> getProductsByFilters({
    List<int>? sizeIdList,
    List<int>? colorIdList,
    List<double>? priceRange,
    String? priceOrderType,
    int? categoryId,
  }) async {
    final uri = Uri.parse('$baseUrl/products/filter/').replace(
      queryParameters: {
        if (sizeIdList != null)
          'size_id_list': sizeIdList.map((e) => e.toString()).toList(),
        if (colorIdList != null)
          'color_id_list': colorIdList.map((e) => e.toString()).toList(),
        if (priceRange != null)
          'price_range': priceRange.map((e) => e.toString()).toList(),
        if (priceOrderType != null) 'price_order_type': priceOrderType,
        if(categoryId != null) 'category_id': categoryId.toString(),
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['products'];
      return await Future.wait(data.map((item) async => SummarizedProduct(
            id: item['id'],
            price: (item['price'] as num?)?.toDouble() ?? 0.0,
            description: item['description'],
            isLiked: item['is_liked'],
            image: await imageService.downloadImage(item['image']) ?? File(''),
          )));
    } else {
      throw Exception("Failed to filter products");
    }
  }

  Future<List<SummarizedProduct>> getProductsByShopId(int shopId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/products/shop/?shop_id=$shopId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['products'];
      return await Future.wait(data.map((item) async => SummarizedProduct(
            id: item['id'],
            price: (item['price'] as num?)?.toDouble() ?? 0.0,
            description: item['description'],
            isLiked: item['is_liked'],
            image: await imageService.downloadImage(item['image']) ?? File(''),
          )));
    } else {
      throw Exception("Failed to fetch products by shop ID");
    }
  }

  Future<void> updateProductImages(int productId, String newImage) async {
    final uri =
        Uri.parse('$baseUrl/products/images/').replace(queryParameters: {
      'product_id': productId.toString(),
      'new_image': newImage,
    });

    final response = await http.post(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to update product images");
    }
  }

  Future<void> toggleProductLike(int userId, int productId) async {
    final uri = Uri.parse('$baseUrl/products/like/').replace(queryParameters: {
      'user_id': userId.toString(),
      'product_id': productId.toString(),
    });

    final response = await http.post(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to toggle product like");
    }
  }
}
