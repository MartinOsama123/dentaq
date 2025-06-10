import 'package:dentaq/core/theme/app_theme.dart';
import 'package:dentaq/core/utils/dialog_utils.dart';
import 'package:dentaq/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_provider.dart';
import '../../../products/domain/models/product.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartInitialization = ref.watch(cartInitializationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF044D5E)),
      ),
      body: cartInitialization.when(
        data: (_) => _buildCartContent(ref, context),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${error.toString()}',
                  style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(cartInitializationProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartContent(WidgetRef ref, BuildContext context) {
    final cartItems = ref.watch(cartItemsProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final discountAmount = ref.watch(discountAmountProvider);
    final total = ref.watch(cartTotalProvider);

    if (cartItems.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _CartItemCard(product: product),
              );
            },
          ),
        ),
        _buildDiscountSection(ref),
        _buildTotalSection(subtotal, discountAmount, total),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            border: Border.all(color: AppTheme.textColor),
          ),
          child: const Text(
            'Due to the Egyptian market situation, prices and the availability of the products your ordered will be confirmed by our customer support call after your order is placed successfully.',
            style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 16,
            ),
          ),
        ),
        _buildCheckoutButton(context),
      ],
    );
  }

  Widget _buildDiscountSection(WidgetRef ref) {
    final discountCodeController = TextEditingController();
    final discountCode = ref.watch(discountCodeProvider);
    final discountPercentage = ref.watch(discountPercentageProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discount Code',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: discountCodeController,
            decoration: InputDecoration(
              hintText: 'Enter discount code',
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              suffixIcon: Container(
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(discountCodeProvider.notifier).state =
                        discountCodeController.text;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3E800),
                    foregroundColor: const Color(0xFF044D5E),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(120, 32),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          if (discountCode.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              discountPercentage > 0
                  ? 'Discount applied: ${(discountPercentage * 100).toInt()}% off'
                  : 'Invalid discount code',
              style: TextStyle(
                color: discountPercentage > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTotalSection(
      double subtotal, double discountAmount, double total) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFA2E3DF),
        border: Border.all(color: AppTheme.textColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal:',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textColor,
                ),
              ),
              Text(
                '${subtotal.toStringAsFixed(2)} EGP',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
          if (discountAmount > 0) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discount:',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textColor,
                  ),
                ),
                Text(
                  '-${discountAmount.toStringAsFixed(2)} EGP',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
          const Divider(color: AppTheme.textColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
              Text(
                '${total.toStringAsFixed(2)} EGP',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomButton(
        onPressed: () {
          context.push('/checkout');
        },
        text: 'Proceed to Checkout',
        borderRadius: 40,
        height: 55,
        width: double.infinity,
        fontSize: 20,
      ),
    );
  }
}

class _CartItemCard extends ConsumerWidget {
  final Product product;

  const _CartItemCard({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = product.quantity ?? 1;
    final price = product.price ?? 0.0;
    final totalPrice = price * quantity;

    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppTheme.textColor),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? 'Unnamed Product',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Remove from cart button
                    /*   InkWell(
                      onTap: () async {
                        if (product.id != null) {
                          try {
                            await ref.read(
                                removeFromCartProvider(product.id!).future);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item removed from cart'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.delete,
                            color: Colors.red, size: 20),
                      ),
                    ), */
                    // Product image
                    Expanded(
                      flex: 2,
                      child: Image.network(
                        product.thumbnail ?? '',
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.error_outline, size: 40),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Product details
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brand: ${product.brand ?? 'Unknown'}',
                            style: const TextStyle(
                              color: AppTheme.textColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manufacturer: ${product.manufacturer ?? 'Unknown'}',
                            style: const TextStyle(
                              color: AppTheme.textColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Unit Price: ${price.toStringAsFixed(2)} EGP',
                            style: const TextStyle(
                              color: AppTheme.textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quantity controls and total price
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Quantity controls
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.textColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Minus button
                        IconButton(
                          onPressed: () async {
                            if (product.id != null) {
                              if (quantity == 1) {
                                try {
                                  await ref.read(
                                      removeFromCartProvider(product.id!)
                                          .future);
                                  if (context.mounted) {
                                    DialogUtils.showSuccessSnackbar(
                                      context: context,
                                      message: 'Item removed from cart',
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {}
                                }
                              } else {
                                await ref.read(updateCartQuantityProvider((
                                  productId: product.id!,
                                  quantity: quantity - 1
                                )).future);
                              }
                            }
                          },
                          icon: const Icon(Icons.remove),
                          style: IconButton.styleFrom(
                            minimumSize: const Size(40, 40),
                          ),
                        ),
                        // Vertical divider
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey,
                        ),
                        // Quantity display
                        Expanded(
                          child: Center(
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF044D5E),
                              ),
                            ),
                          ),
                        ),
                        // Vertical divider
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.grey,
                        ),

                        // Plus button
                        IconButton(
                          onPressed: () async {
                            if (product.id != null) {
                              await ref.read(updateCartQuantityProvider((
                                productId: product.id!,
                                quantity: quantity + 1
                              )).future);
                            }
                          },
                          icon: const Icon(Icons.add),
                          style: IconButton.styleFrom(
                            minimumSize: const Size(40, 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Total price
                Expanded(
                  flex: 2,
                  child: Text(
                    '${totalPrice.toStringAsFixed(2)} EGP',
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
