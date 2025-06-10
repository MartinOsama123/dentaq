import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/auth_manager.dart';
import '../../domain/models/user.dart';
import '../../domain/models/auth_response.dart';

// Provider for managing which tab is currently selected (0 = Login, 1 = Register)
final authTabProvider = StateProvider<int>((ref) => 0);

// Provider for managing password visibility in login form
final loginPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

// Provider for managing password visibility in register form
final registerPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

// Provider for managing confirm password visibility in register form
final confirmPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

// Provider for managing loading state during login
final loginLoadingProvider = StateProvider<bool>((ref) => false);

// Provider for managing loading state during registration
final registerLoadingProvider = StateProvider<bool>((ref) => false);

// Provider for managing terms and conditions checkbox
final termsAcceptedProvider = StateProvider<bool>((ref) => false);

// Provider for managing welcome animation state
final showWelcomeAnimationProvider = StateProvider<bool>((ref) => false);

// Provider for checking if user is logged in
final isLoggedInProvider = FutureProvider<bool>((ref) async {
  return await AuthManager.isLoggedIn();
});

// Provider for getting current user
final currentUserProvider = FutureProvider<User?>((ref) async {
  return await AuthManager.getCurrentUser();
});

// Provider for getting current user ID
final currentUserIdProvider = FutureProvider<String?>((ref) async {
  return await AuthManager.getCurrentUserId();
});

// Provider for getting current token
final currentTokenProvider = FutureProvider<String?>((ref) async {
  return await AuthManager.getCurrentToken();
});

// Provider for login functionality
final loginProvider =
    FutureProvider.family<AuthResponse, ({String email, String password})>(
        (ref, params) async {
  return await AuthManager.login(params.email, params.password);
});

// Provider for register functionality
final registerProvider = FutureProvider.family<
    AuthResponse,
    ({
      String username,
      String password,
      String fullName,
      String email,
      String mobile,
    })>((ref, params) async {
  return await AuthManager.register(
    username: params.username,
    password: params.password,
    fullName: params.fullName,
    email: params.email,
    mobile: params.mobile,
  );
});

// Provider for logout functionality
final logoutProvider = FutureProvider<void>((ref) async {
  await AuthManager.logout();
  // Invalidate all auth-related providers after logout
  ref.invalidate(isLoggedInProvider);
  ref.invalidate(currentUserProvider);
  ref.invalidate(currentUserIdProvider);
  ref.invalidate(currentTokenProvider);
});
