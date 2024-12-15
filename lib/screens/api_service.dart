import 'dart:convert';
import 'package:http/http.dart' as http;

class WooCommerceService {
  final String baseUrl = "https://dmcomputer.sn/wp-json/wc/v3/";
  final String consumerKey = "ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad";
  final String consumerSecret = "cs_c95c5bb6027fd918466dd18823a78a227a2d0b35";

  Future<List<dynamic>> fetchCategories() async {
    final url = Uri.parse('$baseUrl/products/categories?consumer_key=$consumerKey&consumer_secret=$consumerSecret');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch categories");
    }
  }

  Future<List<dynamic>> fetchProducts({String? categoryId}) async {
    final url = Uri.parse('$baseUrl/products?consumer_key=$consumerKey&consumer_secret=$consumerSecret&category=$categoryId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch products");
    }
  }
}
