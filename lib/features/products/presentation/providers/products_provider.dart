import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/product_service.dart';
import '../../domain/models/product.dart';

final productsServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final productService = ref.watch(productsServiceProvider);
  return productService.getProducts();
});

final selectedProductProvider = StateProvider<Product?>((ref) => null);

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  return productsAsync.when(
    data: (products) => products,
    loading: () => [],
    error: (_, __) => [],
  );
});
