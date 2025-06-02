import 'package:dentaq/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/product.dart';
import '../providers/product_details_provider.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productId = product.id;

    // Initialize specs on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (product.specs != null) {
        final specNames = product.specs!
            .where((spec) => spec.name != null)
            .map((spec) => spec.name!)
            .toList();
        ref.read(initializeSpecsProvider(productId))(specNames);
      }
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: product.name ?? 'Product Details',
        showLogo: false,
        showBackButton: true,
        /*  actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement sharing functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // TODO: Implement add to wishlist
            },
          ),
        ], */
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            _buildImageCarousel(ref, productId),

            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.textColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      product.name ?? 'Unnamed Product',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF044D5E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Manufactured in
                  if (product.manufacturer != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Manufactured in ${product.manufacturer}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.textColor,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),

                  // Brand
                  if (product.brand != null)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Brand - ${product.brand}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.textColor,
                          ),
                        )),
                  const SizedBox(height: 16),
                  const Divider(
                    color: AppTheme.textColor,
                  ),
                  // Expandable Specs
                  if (product.specs != null && product.specs!.isNotEmpty) ...[
                    ..._buildExpandableSpecs(ref, productId),
                    const Divider(
                      color: AppTheme.textColor,
                    ),
                  ],
                  const SizedBox(height: 16),
                  // Price Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildPriceSection(),
                  ),

                  const SizedBox(height: 16),
                  const Divider(
                    color: AppTheme.textColor,
                  ),
                  const SizedBox(height: 16),
                  // Quantity and Add to Cart Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildQuantityAndAddToCartSection(
                        ref, productId, context),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(WidgetRef ref, String? productId) {
    final images = product.images ?? [];
    final currentImageIndex = ref.watch(currentImageIndexProvider(productId));

    if (images.isEmpty) {
      return Container(
        height: 300,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            size: 80,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              ref.read(updateImageIndexProvider(productId))(index);
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Page Indicator
          if (images.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentImageIndex == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildExpandableSpecs(WidgetRef ref, String? productId) {
    final selectedSpecs = ref.watch(selectedSpecsProvider(productId));

    return product.specs!.map((spec) {
      if (spec.name == null || spec.value == null) {
        return const SizedBox.shrink();
      }

      return ExpansionTile(
        title: Text(
          spec.name!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF044D5E),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: spec.value!.map((value) {
                final isSelected =
                    selectedSpecs[spec.name!]?.contains(value) ?? false;

                return FilterChip(
                  label: Text(value),
                  selected: isSelected,
                  onSelected: (selected) {
                    ref.read(toggleSpecValueProvider(productId))(
                        spec.name!, value);
                  },
                  selectedColor: const Color(0xFFF3E800),
                  checkmarkColor: const Color(0xFF044D5E),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        const Expanded(
          child: Center(
            child: Text(
              'Price',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppTheme.textColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        const Expanded(
            flex: 3,
            child: Divider(
              color: AppTheme.textColor,
            )),
        const SizedBox(width: 20),
        Expanded(
          child: Center(
            child: Text(
              product.price?.toStringAsFixed(2) ?? '0.00',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityAndAddToCartSection(
      WidgetRef ref, String? productId, BuildContext context) {
    final quantity = ref.watch(productQuantityProvider(productId));

    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.textColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Minus Button
          IconButton(
            onPressed: ref.read(decrementQuantityProvider(productId)),
            icon: const Icon(Icons.remove),
            style: IconButton.styleFrom(
              minimumSize: const Size(40, 40),
            ),
          ),

          // Vertical Divider
          Container(
            height: 40,
            width: 1,
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),

          // Quantity
          Text(
            quantity.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF044D5E),
            ),
          ),

          // Vertical Divider
          Container(
            height: 40,
            width: 1,
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),

          // Plus Button
          IconButton(
            onPressed: ref.read(incrementQuantityProvider(productId)),
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
              minimumSize: const Size(40, 40),
            ),
          ),

          // Vertical Divider
          Container(
            height: 40,
            width: 1,
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),

          // Add to Cart Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {
                try {
                  // Add multiple items to cart based on quantity
                  for (int i = 0; i < quantity; i++) {
                    await ref.read(addToCartProvider(product).future);
                  }

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added $quantity item(s) to cart'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
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
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: const Color(0xFFF3E800),
                foregroundColor: const Color(0xFF044D5E),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
