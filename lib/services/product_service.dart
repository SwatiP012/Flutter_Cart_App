import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com/products';
  int _currentPage = 1;
  bool _hasMore = true;

  Future<List<Product>> fetchProducts() async {
    if (!_hasMore) return [];

    try {
      final response =
          await http.get(Uri.parse('$_baseUrl?page=$_currentPage&limit=10'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = (data['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();

        _currentPage++;
        _hasMore = products.length == 10;

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  bool get hasMore => _hasMore;
}
