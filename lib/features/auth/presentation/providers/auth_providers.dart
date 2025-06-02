import 'package:flutter_riverpod/flutter_riverpod.dart';

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
