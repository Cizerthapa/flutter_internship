import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  final String _baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final productsJson = data['products'] as List<dynamic>;
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }
}
