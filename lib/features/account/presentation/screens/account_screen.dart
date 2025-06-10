import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/auth_utils.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../shared/widgets/custom_button.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final isLoggedInAsync = ref.watch(isLoggedInProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info section
            isLoggedInAsync.when(
              data: (isLoggedIn) {
                if (!isLoggedIn) {
                  return _buildNotLoggedInView(context);
                }

                return currentUserAsync.when(
                  data: (user) {
                    if (user == null) {
                      return _buildNotLoggedInView(context);
                    }
                    return _buildUserInfoView(user, context, ref);
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(
                    child: Text('Error loading user data: $error'),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error checking login status: $error'),
              ),
            ),

            const SizedBox(height: 32),

            // Example of using AuthUtils directly
            FutureBuilder<String?>(
              future: AuthUtils.getUserId(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AuthUtils Example:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('User ID: ${snapshot.data}'),
                          const SizedBox(height: 8),
                          FutureBuilder<String?>(
                            future: AuthUtils.getToken(),
                            builder: (context, tokenSnapshot) {
                              if (tokenSnapshot.hasData) {
                                final token = tokenSnapshot.data!;
                                final shortToken = token.length > 20
                                    ? '${token.substring(0, 20)}...'
                                    : token;
                                return Text('Token: $shortToken');
                              }
                              return const Text('Token: Loading...');
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotLoggedInView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_outline,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'You are not logged in',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Login / Register',
            onPressed: () {
              context.go('/auth');
            },
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoView(user, BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User avatar and basic info
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF044D5E),
              child: Text(
                user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : 'U',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@${user.username}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Logout button
        CustomButton(
          text: 'Logout',
          onPressed: () async {
            try {
              await AuthUtils.logout();
              // Invalidate providers
              ref.invalidate(isLoggedInProvider);
              ref.invalidate(currentUserProvider);
              ref.invalidate(currentUserIdProvider);
              ref.invalidate(currentTokenProvider);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
                context.go('/auth');
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logout failed: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          backgroundColor: Colors.red,
          textColor: Colors.white,
          width: double.infinity,
        ),
      ],
    );
  }
}
