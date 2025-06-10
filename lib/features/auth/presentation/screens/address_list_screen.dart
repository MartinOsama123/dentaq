import 'package:dentaq/features/auth/models/address.dart';
import 'package:dentaq/features/auth/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_button.dart';

import 'address_book_screen.dart';

class AddressListScreen extends ConsumerStatefulWidget {
  const AddressListScreen({super.key});

  @override
  ConsumerState<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends ConsumerState<AddressListScreen> {
  List<Address> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final addresses = await AddressService.getAddresses();
      if (mounted) {
        setState(() {
          _addresses = addresses;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
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

  Future<void> _deleteAddress(String addressId) async {
    final success = await AddressService.deleteAddress(addressId);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _loadAddresses();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete address'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteDialog(Address address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: Text('Are you sure you want to delete "${address.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (address.id != null) {
                  _deleteAddress(address.id!);
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddAddress() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => const AddressBookScreen(),
      ),
    );

    if (result == true) {
      _loadAddresses();
    }
  }

  void _navigateToEditAddress(Address address) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => AddressBookScreen(addressToEdit: address),
      ),
    );

    if (result == true) {
      _loadAddresses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Address Book',
        titleIcon: Icons.location_on_outlined,
        backgroundColor: AppTheme.primaryColor,
        titleColor: AppTheme.textColor,
        horizontalPadding: 16.0,
        showLogo: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Address List
            Flexible(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _addresses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No addresses saved yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap the button below to add your first address',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[500],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount: _addresses.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey[300],
                          ),
                          itemBuilder: (context, index) {
                            final address = _addresses[index];
                            return _buildAddressCard(address);
                          },
                        ),
            ),

            const SizedBox(height: 16),

            CustomButton(
              text: 'Add New Address',
              onPressed: _navigateToAddAddress,
              width: double.infinity,
              height: 48,
              borderRadius: 40,
              fontSize: 20,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address Title and Actions
                /*  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: 
                    ),
                  /*   Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: AppTheme.textColor),
                          onPressed: () => _navigateToEditAddress(address),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteDialog(address),
                          padding: const EdgeInsets.all(8),
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ), */
                  ],
                ), */
                Text(
                  address.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Address Details
                Text(
                  '${address.streetName} ${address.buildingNumber}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Floor ${address.floor}, Apartment ${address.apartment}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  '${address.country} - Postal Code: ${address.cityPostalCode}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                InkWell(
                  onTap: () => _navigateToEditAddress(address),
                  child: Text(
                    'Edit Address',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: AppTheme.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/gps_temp.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
