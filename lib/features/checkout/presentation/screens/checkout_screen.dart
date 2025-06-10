import 'package:dentaq/core/theme/app_theme.dart';
import 'package:dentaq/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../auth/presentation/screens/address_book_screen.dart';
import '../../../auth/models/address.dart';
import '../../../auth/services/address_service.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String? selectedAddress;
  String selectedDeliveryTime = '10am-2pm';
  String selectedShippingMethod = 'regular';
  String selectedPaymentMethod = 'cash';
  bool showCardDetails = false;

  List<Address> savedAddresses = [];
  bool isLoadingAddresses = true;

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardholderNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    setState(() {
      isLoadingAddresses = true;
    });

    try {
      final addresses = await AddressService.getAddresses();
      if (mounted) {
        setState(() {
          savedAddresses = addresses;
          isLoadingAddresses = false;
          // Select first address if available
          if (addresses.isNotEmpty) {
            selectedAddress = addresses.first.id;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoadingAddresses = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading addresses: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = ref.watch(cartSubtotalProvider);
    final discountAmount = ref.watch(discountAmountProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF044D5E)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShippingAddressSection(),
            const Divider(height: 20, color: AppTheme.textColor),
            _buildDeliveryTimeSection(),
            const Divider(height: 20, color: AppTheme.textColor),
            _buildShippingMethodSection(),
            const Divider(height: 20, color: AppTheme.textColor),
            _buildPaymentMethodSection(),
            const Divider(height: 20, color: AppTheme.textColor),
            _buildTotalSection(subtotal, discountAmount, total),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
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
            const SizedBox(height: 24),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const Divider(height: 20, color: AppTheme.textColor),
        // Loading state
        if (isLoadingAddresses)
          const Center(child: CircularProgressIndicator())

        // No addresses state
        else if (savedAddresses.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'No addresses found. Please add a new address.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )

        // Saved addresses
        else
          ...savedAddresses.map((address) => RadioListTile<String>(
                title: Text(
                  address.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor,
                  ),
                ),
                subtitle: Text(
                  '${address.streetName} ${address.buildingNumber}, Floor ${address.floor}, Apt ${address.apartment}, ${address.country}',
                  style: const TextStyle(color: AppTheme.textColor),
                ),
                value: address.id ?? '',
                groupValue: selectedAddress,
                onChanged: (value) {
                  setState(() {
                    selectedAddress = value;
                  });
                },
              )),

        const SizedBox(height: 8),
        // Add new address button
        GestureDetector(
          onTap: () async {
            // Navigate to add address screen
            final result = await Navigator.of(context).push<bool>(
              MaterialPageRoute(
                builder: (context) => const AddressBookScreen(),
              ),
            );
            // Refresh addresses when returning from add address screen
            if (result == true) {
              _loadAddresses(); // Reload addresses after adding new one
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Icon(Icons.add, color: AppTheme.textColor),
                SizedBox(width: 8),
                Text(
                  'Add New Address',
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Delivery Time',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 16),
        RadioListTile<String>(
          title: const Text(
            'From 10AM - 2PM',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: '10am-2pm',
          groupValue: selectedDeliveryTime,
          onChanged: (value) {
            setState(() {
              selectedDeliveryTime = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text(
            'From 5PM - 8PM',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: '5pm-8pm',
          groupValue: selectedDeliveryTime,
          onChanged: (value) {
            setState(() {
              selectedDeliveryTime = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildShippingMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 16),
        RadioListTile<String>(
          title: const Text(
            'Regular Delivery 2-4 Days',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: 'regular',
          groupValue: selectedShippingMethod,
          onChanged: (value) {
            setState(() {
              selectedShippingMethod = value!;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text(
            'Quick Delivery 24 Hours',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: 'quick',
          groupValue: selectedShippingMethod,
          onChanged: (value) {
            setState(() {
              selectedShippingMethod = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Payment Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'On Delivery',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textColor,
          ),
        ),
        const SizedBox(height: 8),
        RadioListTile<String>(
          title: const Text(
            'Cash',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: 'cash',
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value!;
              showCardDetails = false;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text(
            'Credit Card',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: 'credit_card',
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value!;
              showCardDetails = value == 'credit_card';
            });
          },
        ),
        RadioListTile<String>(
          title: const Text(
            'Online Payment',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: 'online_payment',
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value!;
              showCardDetails = value == 'online_payment';
            });
          },
        ),
        RadioListTile<String>(
          title: const Text(
            'Installment',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: 'installment',
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value!;
              showCardDetails = value == 'installment';
            });
          },
        ),
        RadioListTile<String>(
          title: const Text(
            'Valu Installment',
            style: TextStyle(color: AppTheme.textColor),
          ),
          value: 'valu_installment',
          groupValue: selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              selectedPaymentMethod = value!;
              showCardDetails = false;
            });
          },
        ),
        // Card details section
        if (showCardDetails) _buildCardDetailsSection(),
      ],
    );
  }

  Widget _buildCardDetailsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.textColor),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[50],
      ),
      child: Column(
        children: [
          // Payment logos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/mastercard_logo.png',
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 30,
                    width: 50,
                    color: Colors.grey[300],
                    child: const Center(
                        child: Text('MC', style: TextStyle(fontSize: 12))),
                  );
                },
              ),
              Image.asset(
                'assets/images/visa_logo.png',
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 30,
                    width: 50,
                    color: Colors.grey[300],
                    child: const Center(
                        child: Text('VISA', style: TextStyle(fontSize: 12))),
                  );
                },
              ),
              Image.asset(
                'assets/images/paymob_logo.png',
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 30,
                    width: 50,
                    color: Colors.grey[300],
                    child: const Center(
                        child: Text('PayMob', style: TextStyle(fontSize: 10))),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Card number
          TextField(
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Card Number',
              hintText: '1234 5678 9012 3456',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          // Expiry date and CVV
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: expiryDateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                    hintText: 'MM/YY',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    hintText: '123',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Cardholder name
          TextField(
            controller: cardholderNameController,
            decoration: const InputDecoration(
              labelText: 'Cardholder Name',
              hintText: 'John Doe',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection(
      double subtotal, double discountAmount, double total) {
    return Container(
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

  Widget _buildCheckoutButton() {
    return CustomButton(
      onPressed: () {
        // Handle final checkout
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order placed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate back to home or order confirmation
        context.go('/');
      },
      text: 'Proceed to Checkout',
      borderRadius: 40,
      height: 55,
      width: double.infinity,
      fontSize: 20,
    );
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardholderNameController.dispose();
    super.dispose();
  }
}
