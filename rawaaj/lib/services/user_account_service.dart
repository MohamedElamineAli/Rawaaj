import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rawaaj/constants/service_url.dart';
import '../models/shop_model.dart';
import '../models/summarized_shop_model.dart';
import 'image_services.dart';

class UserAccountService {
  final String baseUrl = serviceUrl;
  final ImageService imageService = ImageService();

  Future<bool> isUsernameTaken(String username) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/username-taken/?username=$username'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['is_taken'];
    } else {
      throw Exception("Failed to check username availability");
    }
  }

  Future<bool> isShopNameTaken(String shopName) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/shop-name-taken/?shop_name=$shopName'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['is_taken'];
    } else {
      throw Exception("Failed to check shop name availability");
    }
  }

  Future<int?> addUserAccount({
    required String username,
    required String email,
    required String password,
    String? phoneNumber,
    File? userImage,
  }) async {
    String? imagePath;

    if (userImage != null) {
      imagePath = await imageService.uploadImage(userImage);
    }

    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'language': 'arabic',
        'phone_number': phoneNumber,
        'user_image': imagePath,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['user_id'];
    } else {
      throw Exception("Failed to create user account");
    }
  }

  Future<int?> addShopAccount({
    required String username,
    required String email,
    required String password,
    required String shopName,
    required double longitude,
    required double latitude,
    String? phoneNumber,
    File? userImage,
  }) async {
    String? imagePath;

    if (userImage != null) {
      imagePath = await imageService.uploadImage(userImage);
    }

    final response = await http.post(
      Uri.parse('$baseUrl/shops/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'shop_name': shopName,
        'longitude': longitude,
        'latitude': latitude,
        'phone_number': phoneNumber,
        'user_image': imagePath,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['shop_id'];
    } else {
      throw Exception("Failed to create shop account");
    }
  }

  Future<List<SummarizedShop>> getFollowedShops(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/followed-shops/?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('message')) {
          return [];
        }

        final List<SummarizedShop> followedShops = [];
        for (var shop in responseBody['followed_shops']) {
          final int shopId = shop['shop_id'];
          final String userImageUrl = shop['user_image'];

          final shopImage = await imageService.downloadImage(userImageUrl);

          if(shopImage == null) {
            continue;
          }

          followedShops.add(SummarizedShop(
            id: shopId,
            shopImage: shopImage,
          ));
        }

        return followedShops;
      } else {
        throw Exception("Failed to fetch followed shops: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching followed shops: $e");
    }
  }

  Future<Shop> getShopById(int shopId, {int userId = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/shop/?shop_id=$shopId&user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (responseBody.containsKey('error')) {
          throw Exception(responseBody['error']);
        }

        final Map<String, dynamic> shopData = responseBody['shop'];

        // Download the shop image
        final String userImageUrl = shopData['user_image'];
        final File? shopImage = await imageService.downloadImage(userImageUrl);

        if (shopImage == null) {
          throw Exception("Failed to download shop image");
        }

        // Map the response to the Shop model
        return Shop(
          id: shopData['shop_id'],
          name: shopData['shop_name'],
          location: shopData['address'] ?? 'Unknown Location', // Use address as location
          productsNum: shopData['products_num'],
          followersNum: shopData['followers_num'],
          isFollowed: shopData['is_followed'] ?? false, // Default to false if not provided
          shopImage: shopImage,
          long: shopData['longitude'],
          lat: shopData['latitude'],
        );
      } else {
        throw Exception("Failed to fetch shop details: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching shop details: $e");
    }
  }

  Future<bool> toggleFollowing(int userId, int shopId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/shops/toggle-following/?user_id=$userId&shop_id=$shopId'),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to toggle follow status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error toggling follow status: $e");
    }
  }

  Future<Map<String, dynamic>> getPasswordByUsername(String username) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/password/?username=$username'),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Failed to fetch password: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching password: $e");
    }
  }

  Future<bool> updateUserImage(int userId, File userImage) async {
    try {
      final imagePath = await imageService.uploadImage(userImage);

      if(imagePath == null) {
        print('image path is null');
        return false;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/user/image/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'new_user_image': imagePath,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to update user image");
      }
    } catch (e) {
      throw Exception("Error updating user image: $e");
    }
  }

}
