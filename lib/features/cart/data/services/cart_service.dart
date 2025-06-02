import 'package:dentaq/features/products/domain/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartService {
  static const String _boxName = 'cartBox';
  Box<Product>? _cartBox;
  bool _isInitialized = false;
  static bool _hiveInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    if (!_hiveInitialized) {
      await Hive.initFlutter();
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ProductAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(CategoryAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(SpecAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(ProductSizeAdapter());
      }
      _hiveInitialized = true;
    }

    if (!Hive.isBoxOpen(_boxName)) {
      _cartBox = await Hive.openBox<Product>(_boxName);
    } else {
      _cartBox = Hive.box<Product>(_boxName);
    }

    _isInitialized = true;
  }

  Future<void> addToCart(Product product) async {
    await init();

    if (product.id == null) {
      throw Exception('Product ID cannot be null');
    }

    final existingProduct = _cartBox!.values
        .firstWhere((p) => p.id == product.id, orElse: () => product);

    if (existingProduct != product) {
      // Update quantity if product exists
      final updatedProduct = existingProduct.copyWith(
        quantity: (existingProduct.quantity ?? 0) + 1,
      );
      await _cartBox!.put(existingProduct.id!, updatedProduct);
    } else {
      // Add new product with quantity 1
      await _cartBox!.put(product.id!, product.copyWith(quantity: 1));
    }
  }

  List<Product> getCartItems() {
    if (!_isInitialized) return [];
    return _cartBox!.values.toList();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    await init();

    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }

    final existingProduct = _cartBox!.values.firstWhere(
        (p) => p.id == productId,
        orElse: () => throw Exception('Product not found in cart'));

    final updatedProduct = existingProduct.copyWith(quantity: quantity);
    await _cartBox!.put(productId, updatedProduct);
  }

  Future<void> removeFromCart(String productId) async {
    await init();
    await _cartBox!.delete(productId);
  }
}
