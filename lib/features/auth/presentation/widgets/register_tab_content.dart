import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'social_login_buttons.dart';

class RegisterTabContent extends ConsumerStatefulWidget {
  const RegisterTabContent({super.key});

  @override
  ConsumerState<RegisterTabContent> createState() => _RegisterTabContentState();
}

class _RegisterTabContentState extends ConsumerState<RegisterTabContent> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final termsAccepted = ref.read(termsAcceptedProvider);
      if (!termsAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the Terms & Conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ref.read(registerLoadingProvider.notifier).state = true;

      try {
        // Call the register API
        await ref.read(registerProvider((
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          mobile: _mobileController.text.trim(),
        )).future);

        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful! Loading dashboard...'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          // Trigger welcome animation and invalidate auth providers
          ref.read(showWelcomeAnimationProvider.notifier).state = true;
          ref.invalidate(isLoggedInProvider);
          ref.invalidate(currentUserProvider);
          ref.invalidate(currentUserIdProvider);
          ref.invalidate(currentTokenProvider);
        }
      } catch (e) {
        if (mounted) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Registration failed: ${e.toString().replaceFirst('Exception: ', '')}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          ref.read(registerLoadingProvider.notifier).state = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(registerPasswordVisibilityProvider);
    final isConfirmPasswordVisible =
        ref.watch(confirmPasswordVisibilityProvider);
    final isLoading = ref.watch(registerLoadingProvider);
    final termsAccepted = ref.watch(termsAcceptedProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Social login buttons
          const SocialLoginButtons(),

          const SizedBox(height: 24),

          // Divider with "OR" text
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),

          const SizedBox(height: 24),

          // Username field
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              if (value.length < 3) {
                return 'Username must be at least 3 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Full name field
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Email field
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Mobile field
          TextFormField(
            controller: _mobileController,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              }
              if (value.length < 10) {
                return 'Please enter a valid mobile number';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Password field
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  ref.read(registerPasswordVisibilityProvider.notifier).state =
                      !isPasswordVisible;
                },
              ),
            ),
            obscureText: !isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Confirm password field
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                icon: Icon(
                  isConfirmPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  ref.read(confirmPasswordVisibilityProvider.notifier).state =
                      !isConfirmPasswordVisible;
                },
              ),
            ),
            obscureText: !isConfirmPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Terms and conditions checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: termsAccepted,
                onChanged: (value) {
                  ref.read(termsAcceptedProvider.notifier).state =
                      value ?? false;
                },
                activeColor: const Color(0xFF044D5E),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'I agree to the Terms & Conditions and Privacy Policy',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF044D5E),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Sign up button
          CustomButton(
            text: 'Sign Up',
            onPressed: _handleRegister,
            isLoading: isLoading,
            width: double.infinity,
            height: 48,
          ),
        ],
      ),
    );
  }
}
