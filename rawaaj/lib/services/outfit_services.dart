import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rawaaj/constants/service_url.dart';
import '../models/outfit_model.dart';
import '../models/summarized_outfit_model.dart';
import 'image_services.dart';

class OutfitService {
  final String baseUrl = serviceUrl;
  final ImageService imageService = ImageService();

  Future<int?> addOutfit(Outfit outfit) async {
    final imagePath = await imageService.uploadImage(outfit.outfitImage);

    final response = await http.post(
      Uri.parse('$baseUrl/outfits/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': 1, // Replace with dynamic user ID if needed
        'outfit_image': imagePath,
        'total_price': outfit.totalPrice,
        'num_of_likes': outfit.numOfLikes,
        'description': outfit.description,
        'outfit_components': outfit.outfitComponents,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['outfit_id'];
    } else {
      throw Exception("Failed to add outfit");
    }
  }

  Future<Outfit?> getOutfitById(int outfitId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/outfit/?outfit_id=$outfitId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return Outfit(
        id: data['id'],
        outfitImage:
            await imageService.downloadImage(data['outfit_image']) ?? File(''),
        totalPrice: (data['total_price'] as num).toDouble(),
        numOfLikes: data['num_of_likes'],
        isLiked: data['is_liked'],
        description: data['description'],
        outfitComponents: List<int>.from(data['outfit_components']),
      );
    } else {
      throw Exception("Failed to fetch outfit by ID");
    }
  }

  Future<List<SummarizedOutfit>> getAllOutfits() async {
    final response = await http.get(Uri.parse('$baseUrl/outfits/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['outfits'];
      return await Future.wait(data.map((item) async => SummarizedOutfit(
            id: item['id'],
            outfitImage:
                await imageService.downloadImage(item['outfit_image']) ??
                    File(''),
            totalPrice: (item['total_price'] as num).toDouble(),
            numOfLikes: item['num_of_likes'],
            isLiked: item['is_liked'],
          )));
    } else {
      throw Exception("Failed to fetch outfits");
    }
  }

  Future<List<SummarizedOutfit>> getOutfitsByContextType(
      String contextType, int userId) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/outfits/context/?context_type=$contextType&user_id=$userId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['outfits'];
      return await Future.wait(data.map((item) async => SummarizedOutfit(
            id: item['id'],
            outfitImage:
                await imageService.downloadImage(item['outfit_image']) ??
                    File(''),
            totalPrice: (item['total_price'] as num).toDouble(),
            numOfLikes: item['num_of_likes'],
            isLiked: item['is_liked'],
          )));
    } else {
      throw Exception("Failed to fetch outfits by context type");
    }
  }

  Future<List<SummarizedOutfit>> searchOutfitsByDescription(
      String keyword) async {
    final response = await http.get(
      Uri.parse('$baseUrl/outfits/search/?keyword=$keyword'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['outfits'];
      return await Future.wait(data.map((item) async => SummarizedOutfit(
            id: item['id'],
            outfitImage:
                await imageService.downloadImage(item['outfit_image']) ??
                    File(''),
            totalPrice: (item['total_price'] as num).toDouble(),
            numOfLikes: item['num_of_likes'],
            isLiked: item['is_liked'],
          )));
    } else {
      throw Exception("Failed to search outfits");
    }
  }

  Future<List<SummarizedOutfit>> getOutfitsByFilters({
    List<int>? sizeIdList,
    List<int>? colorIdList,
    List<double>? priceRange,
    String? priceOrderType,
  }) async {
    final uri = Uri.parse('$baseUrl/outfits/filter/').replace(
      queryParameters: {
        if (sizeIdList != null)
          'size_id_list': sizeIdList.map((e) => e.toString()).toList(),
        if (colorIdList != null)
          'color_id_list': colorIdList.map((e) => e.toString()).toList(),
        if (priceRange != null)
          'price_range': priceRange.map((e) => e.toString()).toList(),
        if (priceOrderType != null) 'price_order_type': priceOrderType,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['outfits'];
      return await Future.wait(data.map((item) async => SummarizedOutfit(
            id: item['id'],
            outfitImage:
                await imageService.downloadImage(item['outfit_image']) ??
                    File(''),
            totalPrice: (item['total_price'] as num).toDouble(),
            numOfLikes: item['num_of_likes'],
            isLiked: item['is_liked'],
          )));
    } else {
      throw Exception("Failed to filter outfits");
    }
  }

  Future<void> toggleOutfitLike(int userId, int outfitId) async {
    final uri = Uri.parse('$baseUrl/outfits/like/').replace(queryParameters: {
      'user_id': userId.toString(),
      'outfit_id': outfitId.toString(),
    });

    final response = await http.post(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to like/unlike outfit");
    }
  }

  Future<void> trackOutfitVisit(int userId, int outfitId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/outfits/visit/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'outfit_id': outfitId}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to track outfit visit");
    }
  }

  Future<void> updateOutfitImage(int outfitId, String newOutfitImage) async {
    final response = await http.post(Uri.parse('$baseUrl/outfits/image/')
        .replace(queryParameters: {
      'outfit_id': outfitId.toString(),
      'new_outfit_image': newOutfitImage
    }));

    if (response.statusCode != 200) {
      throw Exception("Failed to update outfit image ${response.body}");
    } else {
      print("Outfit image updated successfully!");
    }
  }
}
