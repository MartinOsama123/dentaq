import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dentaq/core/constants/app_constants.dart';
import 'package:dentaq/core/utils/network_helper.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/product.dart';

class ProductService {
  final String baseUrl = AppConstants.baseUrl;

  // Create HTTP client with better configuration
  http.Client get _httpClient {
    return http.Client();
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'DentaQ-Flutter-App/1.0.0',
      };

  Future<List<Product>> getProducts() async {
    // Check network connectivity first
    await NetworkHelper.logNetworkInfo();

    final client = _httpClient;
    try {
      final uri = Uri.parse('$baseUrl/products');
      print('Making request to: $uri'); // Debug log

      final response = await client
          .get(
        uri,
        headers: _headers,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException(
              'Request timeout', const Duration(seconds: 30));
        },
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['data'];

        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load products: ${response.statusCode} - ${response.body}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: No internet connection - $e');
    } on TimeoutException catch (e) {
      throw Exception('Network error: Request timeout - $e');
    } on FormatException catch (e) {
      throw Exception('Data error: Invalid response format - $e');
    } catch (e) {
      throw Exception('Failed to load products: $e');
    } finally {
      client.close();
    }
  }

  Future<Product> getProductById(String id) async {
    // Check network connectivity first
    await NetworkHelper.logNetworkInfo();

    final client = _httpClient;
    try {
      final uri = Uri.parse('$baseUrl/products/$id');
      print('Making request to: $uri'); // Debug log

      final response = await client
          .get(
        uri,
        headers: _headers,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException(
              'Request timeout', const Duration(seconds: 30));
        },
      );

      print('Response status: ${response.statusCode}'); // Debug log

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Product.fromJson(data['data']);
      } else {
        throw Exception(
            'Failed to load product: ${response.statusCode} - ${response.body}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: No internet connection - $e');
    } on TimeoutException catch (e) {
      throw Exception('Network error: Request timeout - $e');
    } on FormatException catch (e) {
      throw Exception('Data error: Invalid response format - $e');
    } catch (e) {
      throw Exception('Failed to load product: $e');
    } finally {
      client.close();
    }
  }
}
