import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'social_login_buttons.dart';

class LoginTabContent extends ConsumerStatefulWidget {
  const LoginTabContent({super.key});

  @override
  ConsumerState<LoginTabContent> createState() => _LoginTabContentState();
}

class _LoginTabContentState extends ConsumerState<LoginTabContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      ref.read(loginLoadingProvider.notifier).state = true;

      try {
        // Call the login API
        await ref.read(loginProvider((
          email: _emailController.text.trim(),
          password: _passwordController.text,
        )).future);

        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful! Loading dashboard...'),
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
                  'Login failed: ${e.toString().replaceFirst('Exception: ', '')}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          ref.read(loginLoadingProvider.notifier).state = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(loginPasswordVisibilityProvider);
    final isLoading = ref.watch(loginLoadingProvider);

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
                  ref.read(loginPasswordVisibilityProvider.notifier).state =
                      !isPasswordVisible;
                },
              ),
            ),
            obscureText: !isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),

          const SizedBox(height: 8),

          // Forgot password link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implement forgot password
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFF044D5E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Login button
          CustomButton(
            text: 'Login',
            onPressed: _handleLogin,
            isLoading: isLoading,
            width: double.infinity,
            height: 48,
          ),
        ],
      ),
    );
  }
}
