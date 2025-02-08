import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:rawaaj/constants/service_url.dart';

class ImageService {
  final String baseUrl = serviceUrl;

  Future<String?> uploadImageFromAssets(String assetPath, {String bucketName = "products"}) async {
    try {
      // Load image as bytes from the assets folder
      final ByteData byteData = await rootBundle.load(assetPath);
      final List<int> imageBytes = byteData.buffer.asUint8List();

      // Extract the filename from the asset path (e.g., "suit (1).jpg")
      final String fileName = assetPath.split('/').last;

      var uri = Uri.parse("$baseUrl/upload-image/");
      var request = http.MultipartRequest("POST", uri)
        ..fields['bucket_name'] = bucketName
        ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: fileName));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        return jsonDecode(responseBody)['filename']; // Returning the unique filename
      } else {
        throw Exception("Failed to upload image");
      }
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }

  Future<String?> uploadImage(File imageFile, {String bucketName = "products"}) async {
    var uri = Uri.parse("$baseUrl/upload-image/");
    var request = http.MultipartRequest("POST", uri)
      ..fields['bucket_name'] = bucketName
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody)['filename']; // Returning the unique filename
    } else {
      throw Exception("Failed to upload image");
    }
  }


  Future<File?> downloadImage(String fileName, {String bucketName = "products"}) async {
    var uri = Uri.parse("$baseUrl/download-image/?file_name=$fileName&bucket_name=$bucketName");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var imageContentBase64 = jsonResponse['image_content'];

      if (imageContentBase64 != null) {
        var bytes = base64Decode(imageContentBase64);

        var tempDir = await getTemporaryDirectory();
        File file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(bytes);
        return file;
      } else {
        throw Exception("Invalid image content received");
      }
    } else {
      throw Exception("Failed to download image");
    }
  }
}