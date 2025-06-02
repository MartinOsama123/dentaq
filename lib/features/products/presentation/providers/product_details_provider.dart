import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for current image index in carousel
final currentImageIndexProvider =
    StateProvider.family<int, String?>((ref, productId) => 0);

// Provider for product quantity
final productQuantityProvider =
    StateProvider.family<int, String?>((ref, productId) => 1);

// Provider for selected specifications
final selectedSpecsProvider =
    StateProvider.family<Map<String, List<String>>, String?>(
        (ref, productId) => {});

// Provider for managing quantity increment
final incrementQuantityProvider =
    Provider.family<void Function(), String?>((ref, productId) {
  return () {
    final currentQuantity = ref.read(productQuantityProvider(productId));
    ref.read(productQuantityProvider(productId).notifier).state =
        currentQuantity + 1;
  };
});

// Provider for managing quantity decrement
final decrementQuantityProvider =
    Provider.family<void Function(), String?>((ref, productId) {
  return () {
    final currentQuantity = ref.read(productQuantityProvider(productId));
    if (currentQuantity > 1) {
      ref.read(productQuantityProvider(productId).notifier).state =
          currentQuantity - 1;
    }
  };
});

// Provider for toggling spec values
final toggleSpecValueProvider =
    Provider.family<void Function(String, String), String?>((ref, productId) {
  return (String specName, String value) {
    final currentSpecs = Map<String, List<String>>.from(
        ref.read(selectedSpecsProvider(productId)));

    if (currentSpecs[specName] == null) {
      currentSpecs[specName] = [];
    }

    if (currentSpecs[specName]!.contains(value)) {
      currentSpecs[specName]!.remove(value);
    } else {
      currentSpecs[specName]!.add(value);
    }

    ref.read(selectedSpecsProvider(productId).notifier).state = currentSpecs;
  };
});

// Provider for updating current image index
final updateImageIndexProvider =
    Provider.family<void Function(int), String?>((ref, productId) {
  return (int index) {
    ref.read(currentImageIndexProvider(productId).notifier).state = index;
  };
});

// Provider for initializing selected specs based on product specs
final initializeSpecsProvider =
    Provider.family<void Function(List<String>), String?>((ref, productId) {
  return (List<String> specNames) {
    final Map<String, List<String>> initialSpecs = {};
    for (final specName in specNames) {
      initialSpecs[specName] = [];
    }
    ref.read(selectedSpecsProvider(productId).notifier).state = initialSpecs;
  };
});
