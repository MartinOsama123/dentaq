import '../../../auth/domain/models/auth_response.dart';
import '../../../auth/domain/models/user.dart';
import 'auth_service.dart';
import 'auth_storage_service.dart';

class AuthManager {
  static final AuthService _authService = AuthService();

  // Login method that calls API and saves user data
  static Future<AuthResponse> login(String email, String password) async {
    try {
      final authResponse = await _authService.login(email, password);

      // Save token and user data to local storage
      await AuthStorageService.saveToken(authResponse.token);
      await AuthStorageService.saveUser(authResponse.user);

      return authResponse;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Register method that calls API and saves user data
  static Future<AuthResponse> register({
    required String username,
    required String password,
    required String fullName,
    required String email,
    required String mobile,
  }) async {
    try {
      final authResponse = await _authService.register(
        username: username,
        password: password,
        fullName: fullName,
        email: email,
        mobile: mobile,
      );

      // Save token and user data to local storage
      await AuthStorageService.saveToken(authResponse.token);
      await AuthStorageService.saveUser(authResponse.user);

      return authResponse;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Logout method
  static Future<void> logout() async {
    await AuthStorageService.clearAuthData();
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    return await AuthStorageService.isLoggedIn();
  }

  // Get current user
  static Future<User?> getCurrentUser() async {
    return await AuthStorageService.getUser();
  }

  // Get current user ID
  static Future<String?> getCurrentUserId() async {
    return await AuthStorageService.getUserId();
  }

  // Get current token
  static Future<String?> getCurrentToken() async {
    return await AuthStorageService.getToken();
  }
}
