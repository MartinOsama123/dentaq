import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/models/user.dart';

class AuthStorageService {
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save authentication token
  static Future<void> saveToken(String token) async {
    await _initPrefs();
    await _prefs!.setString(AppConstants.tokenKey, token);
  }

  // Get authentication token
  static Future<String?> getToken() async {
    await _initPrefs();
    return _prefs!.getString(AppConstants.tokenKey);
  }

  // Save user data
  static Future<void> saveUser(User user) async {
    await _initPrefs();
    final userJson = json.encode(user.toJson());
    await _prefs!.setString(AppConstants.userKey, userJson);
  }

  // Get user data
  static Future<User?> getUser() async {
    await _initPrefs();
    final userJson = _prefs!.getString(AppConstants.userKey);
    if (userJson != null) {
      try {
        final userMap = json.decode(userJson) as Map<String, dynamic>;
        return User.fromJson(userMap);
      } catch (e) {
        print('Error parsing user data: $e');
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Clear all auth data (logout)
  static Future<void> clearAuthData() async {
    await _initPrefs();
    await _prefs!.remove(AppConstants.tokenKey);
    await _prefs!.remove(AppConstants.userKey);
  }

  // Get user ID
  static Future<String?> getUserId() async {
    final user = await getUser();
    return user?.id;
  }
}
