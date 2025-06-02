import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../widgets/login_tab_content.dart';
import '../widgets/register_tab_content.dart';

class SignFlowScreen extends ConsumerWidget {
  const SignFlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(authTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ref.read(authTabProvider.notifier).state = 0,
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: currentTab == 0
                                  ? const Color(0xFF044D5E)
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 2,
                            color: currentTab == 0
                                ? const Color(0xFF044D5E)
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => ref.read(authTabProvider.notifier).state = 1,
                      child: Column(
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: currentTab == 1
                                  ? const Color(0xFF044D5E)
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 2,
                            color: currentTab == 1
                                ? const Color(0xFF044D5E)
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Tab content
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: currentTab == 0
                    ? const LoginTabContent(key: ValueKey('login'))
                    : const RegisterTabContent(key: ValueKey('register')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
