import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dentaq/core/constants/app_constants.dart';
import 'package:dentaq/core/utils/network_helper.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/auth_response.dart';

class AuthService {
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

  Future<AuthResponse> login(String email, String password) async {
    // Check network connectivity first
    await NetworkHelper.logNetworkInfo();

    final client = _httpClient;
    try {
      final uri = Uri.parse('$baseUrl/auth/login');
      final body = json.encode({
        'email': email,
        'password': password,
      });

      print('Making login request to: $uri'); // Debug log
      print('Request body: $body'); // Debug log

      final response = await client
          .post(
        uri,
        headers: _headers,
        body: body,
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
        return AuthResponse.fromJson(data);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(
            errorData['message'] ?? 'Login failed: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: No internet connection - $e');
    } on TimeoutException catch (e) {
      throw Exception('Network error: Request timeout - $e');
    } on FormatException catch (e) {
      throw Exception('Data error: Invalid response format - $e');
    } catch (e) {
      throw Exception('Failed to login: $e');
    } finally {
      client.close();
    }
  }

  Future<AuthResponse> register({
    required String username,
    required String password,
    required String fullName,
    required String email,
    required String mobile,
  }) async {
    // Check network connectivity first
    await NetworkHelper.logNetworkInfo();

    final client = _httpClient;
    try {
      final uri = Uri.parse('$baseUrl/auth/register');
      final body = json.encode({
        'username': username,
        'password': password,
        'fullName': fullName,
        'email': email,
        'mobile': mobile,
      });

      print('Making register request to: $uri'); // Debug log
      print('Request body: $body'); // Debug log

      final response = await client
          .post(
        uri,
        headers: _headers,
        body: body,
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return AuthResponse.fromJson(data);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['message'] ??
            'Registration failed: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('Network error: No internet connection - $e');
    } on TimeoutException catch (e) {
      throw Exception('Network error: Request timeout - $e');
    } on FormatException catch (e) {
      throw Exception('Data error: Invalid response format - $e');
    } catch (e) {
      throw Exception('Failed to register: $e');
    } finally {
      client.close();
    }
  }
}
