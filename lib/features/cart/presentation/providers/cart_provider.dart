import 'package:dentaq/features/products/domain/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/cart_service.dart';

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService();
});

final cartInitializationProvider = FutureProvider<void>((ref) async {
  final cartService = ref.watch(cartServiceProvider);
  await cartService.init();
});

final cartItemsProvider = Provider<List<Product>>((ref) {
  // Ensure initialization is complete
  ref.watch(cartInitializationProvider);
  final cartService = ref.watch(cartServiceProvider);
  return cartService.getCartItems();
});

final addToCartProvider =
    FutureProvider.family<void, Product>((ref, product) async {
  // Ensure initialization is complete
  await ref.watch(cartInitializationProvider.future);
  final cartService = ref.watch(cartServiceProvider);
  await cartService.addToCart(product);
  ref.invalidate(cartItemsProvider);
});

// Provider for updating cart item quantity
final updateCartQuantityProvider =
    FutureProvider.family<void, ({String productId, int quantity})>(
        (ref, params) async {
  await ref.watch(cartInitializationProvider.future);
  final cartService = ref.watch(cartServiceProvider);
  await cartService.updateQuantity(params.productId, params.quantity);
  ref.invalidate(cartItemsProvider);
});

// Provider for removing item from cart
final removeFromCartProvider =
    FutureProvider.family<void, String>((ref, productId) async {
  await ref.watch(cartInitializationProvider.future);
  final cartService = ref.watch(cartServiceProvider);
  await cartService.removeFromCart(productId);
  ref.invalidate(cartItemsProvider);
});

// Provider for discount code
final discountCodeProvider = StateProvider<String>((ref) => '');

// Provider for discount percentage (mock values for demo)
final discountPercentageProvider = Provider<double>((ref) {
  final discountCode = ref.watch(discountCodeProvider);
  switch (discountCode.toLowerCase()) {
    case 'save10':
      return 0.10;
    case 'save20':
      return 0.20;
    case 'save30':
      return 0.30;
    default:
      return 0.0;
  }
});

// Provider for cart subtotal
final cartSubtotalProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartItemsProvider);
  return cartItems.fold(0.0, (total, product) {
    final price = product.price ?? 0.0;
    final quantity = product.quantity ?? 1;
    return total + (price * quantity);
  });
});

// Provider for discount amount
final discountAmountProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  final discountPercentage = ref.watch(discountPercentageProvider);
  return subtotal * discountPercentage;
});

// Provider for cart total
final cartTotalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(cartSubtotalProvider);
  final discountAmount = ref.watch(discountAmountProvider);
  return subtotal - discountAmount;
});
