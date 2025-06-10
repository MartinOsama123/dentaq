import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/auth_utils.dart';
import '../providers/auth_providers.dart';
import 'sign_flow_screen.dart';
import 'account_information_screen.dart';
import 'address_list_screen.dart';

class UserDashboardScreen extends ConsumerStatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  ConsumerState<UserDashboardScreen> createState() =>
      _UserDashboardScreenState();
}

class _UserDashboardScreenState extends ConsumerState<UserDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showWelcomeAnimation = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedInAsync = ref.watch(isLoggedInProvider);
    final currentUserAsync = ref.watch(currentUserProvider);
    final showWelcomeAnimation = ref.watch(showWelcomeAnimationProvider);

    // Trigger animation when showWelcomeAnimation becomes true
    if (showWelcomeAnimation && !_showWelcomeAnimation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _showWelcomeAnimation = true;
        });
        _animationController.forward();

        // Reset the animation state after completing
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            ref.read(showWelcomeAnimationProvider.notifier).state = false;
            setState(() {
              _showWelcomeAnimation = false;
            });
            _animationController.reset();
          }
        });
      });
    }

    return isLoggedInAsync.when(
      data: (isLoggedIn) {
        if (!isLoggedIn) {
          // Show auth screen if not logged in
          return const SignFlowScreen();
        }

        // Show dashboard if logged in
        return currentUserAsync.when(
          data: (user) {
            if (user == null) {
              return const SignFlowScreen();
            }
            return _buildDashboard(context, ref, user);
          },
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => const SignFlowScreen(),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => const SignFlowScreen(),
    );
  }

  Widget _buildDashboard(BuildContext context, WidgetRef ref, user) {
    final menuItems = [
      {
        'title': 'My Wishlist',
        'icon': Icons.favorite_outline,
        'onTap': () {
          context.go('/wishlist');
        },
      },
      {
        'title': 'Account Information',
        'icon': Icons.person_outline,
        'onTap': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AccountInformationScreen(),
            ),
          );
        },
      },
      {
        'title': 'Address Book',
        'icon': Icons.location_on_outlined,
        'onTap': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddressListScreen(),
            ),
          );
        },
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications_outlined,
        'onTap': () {
          // TODO: Navigate to notifications screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notifications - Coming Soon')),
          );
        },
      },
      {
        'title': 'Logout',
        'icon': Icons.logout,
        'onTap': () => _handleLogout(context, ref),
        'isLogout': true,
      },
    ];

    Widget dashboardContent = Scaffold(
      /*  appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        elevation: 0,
      ), */
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            /*        // User welcome section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.textColor,
                    child: Text(
                      user.fullName.isNotEmpty
                          ? user.fullName[0].toUpperCase()
                          : 'U',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome, ${user.fullName}!',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
        
            // Browse Products Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.go('/products');
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Browse Products'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ), */

            // Menu items
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(0),
                itemCount: menuItems.length,
                separatorBuilder: (context, index) {
                  final isNextItemLogout = index + 1 < menuItems.length &&
                      (menuItems[index + 1]['isLogout'] as bool? ?? false);
                  return Divider(
                    height: 5,
                    thickness: 1,
                    color: isNextItemLogout ? Colors.red : AppTheme.textColor,
                  );
                },
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isLogout = item['isLogout'] as bool? ?? false;
                  final isEven = (index + 1) % 2 == 0;

                  return Container(
                    color: isEven ? AppTheme.backgroundColor : Colors.white,
                    child: ListTile(
                      leading: Icon(
                        item['icon'] as IconData,
                        color: isLogout ? Colors.red : AppTheme.textColor,
                        size: 24,
                      ),
                      title: Text(
                        item['title'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isLogout ? Colors.red : AppTheme.textColor,
                        ),
                      ),
                      /*  trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: isLogout
                            ? Colors.red
                            : isEven
                                ? Colors.white.withOpacity(0.7)
                                : AppTheme.textColor.withOpacity(0.7),
                      ), */
                      onTap: item['onTap'] as VoidCallback,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 10.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    // Apply animation if showing welcome animation
    if (_showWelcomeAnimation) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: dashboardContent,
            ),
          );
        },
      );
    }

    return dashboardContent;
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
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
          // Stay on the same screen, but it will now show the auth flow
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
    }
  }
}
