import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rawaaj/constants/service_url.dart';

class WilayasService {
  final String baseUrl = serviceUrl;

  Future<Map<String, int>> getAllWilayas() async {
    final response = await http.get(Uri.parse('$baseUrl/wilayas/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {for (var item in data['wilayas']) item['name']: item['id']};
    } else {
      throw Exception("Failed to load wilayas");
    }
  }

  Future<List<String>> getWilayaNames() async {
    final response = await http.get(Uri.parse('$baseUrl/wilayas/names/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data['wilaya_names']);
    } else {
      throw Exception("Failed to load wilaya names");
    }
  }

  Future<int?> getWilayaId(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/wilayas/id/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['wilaya_id'];
    } else {
      throw Exception("Wilaya not found");
    }
  }
}
