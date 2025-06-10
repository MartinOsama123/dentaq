import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/products/presentation/screens/product_details_screen.dart';
import '../../features/products/domain/models/product.dart';
import '../../features/navigation/presentation/screens/navigation_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/wishlist/presentation/screens/wishlist_screen.dart';
import '../../features/auth/presentation/screens/sign_flow_screen.dart';
import '../../features/auth/presentation/screens/user_dashboard_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      // Authentication routes (outside shell)
      GoRoute(
        path: '/auth',
        builder: (context, state) => const SignFlowScreen(),
      ),

      // Main app routes (with shell/navigation)
      ShellRoute(
        builder: (context, state, child) {
          return NavigationScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) => '/products',
          ),
          GoRoute(
            path: '/products',
            builder: (context, state) => const ProductsScreen(),
            routes: [
              GoRoute(
                path: 'details',
                builder: (context, state) {
                  final product = state.extra as Product;
                  return ProductDetailsScreen(product: product);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            path: '/checkout',
            builder: (context, state) => const CheckoutScreen(),
          ),
          GoRoute(
            path: '/wishlist',
            builder: (context, state) => const WishlistScreen(),
          ),
          GoRoute(
            path: '/account',
            builder: (context, state) => const UserDashboardScreen(),
          ),
        ],
      ),
    ],
  );
});
