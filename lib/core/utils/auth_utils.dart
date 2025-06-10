import '../../features/auth/data/services/auth_manager.dart';
import '../../features/auth/domain/models/user.dart';

/// Utility class for easy access to authentication data across the app
class AuthUtils {
  /// Get the current user's ID
  /// Returns null if user is not logged in
  static Future<String?> getUserId() async {
    return await AuthManager.getCurrentUserId();
  }

  /// Get the current authentication token
  /// Returns null if user is not logged in
  static Future<String?> getToken() async {
    return await AuthManager.getCurrentToken();
  }

  /// Get the current user data
  /// Returns null if user is not logged in
  static Future<User?> getUser() async {
    return await AuthManager.getCurrentUser();
  }

  /// Check if user is currently logged in
  static Future<bool> isLoggedIn() async {
    return await AuthManager.isLoggedIn();
  }

  /// Get the current user's email
  /// Returns null if user is not logged in
  static Future<String?> getUserEmail() async {
    final user = await getUser();
    return user?.email;
  }

  /// Get the current user's full name
  /// Returns null if user is not logged in
  static Future<String?> getUserFullName() async {
    final user = await getUser();
    return user?.fullName;
  }

  /// Get the current user's username
  /// Returns null if user is not logged in
  static Future<String?> getUsername() async {
    final user = await getUser();
    return user?.username;
  }

  /// Logout the current user
  static Future<void> logout() async {
    await AuthManager.logout();
  }

  /// Get authorization header for API requests
  /// Returns null if user is not logged in
  static Future<Map<String, String>?> getAuthHeaders() async {
    final token = await getToken();
    if (token != null) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
    return null;
  }
}
