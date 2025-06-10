import 'package:dentaq/features/auth/models/address.dart';
import 'package:dentaq/features/auth/services/address_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

class AddressBookScreen extends ConsumerStatefulWidget {
  final Address? addressToEdit;

  const AddressBookScreen({super.key, this.addressToEdit});

  @override
  ConsumerState<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends ConsumerState<AddressBookScreen> {
  final _formKey = GlobalKey<FormState>();

  // Address controllers
  final _addressTitleController = TextEditingController();
  final _streetNameController = TextEditingController();
  final _buildingNumberController = TextEditingController();
  final _floorController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _areaController = TextEditingController();
  final _postalCodeController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.addressToEdit != null) {
      _populateFields();
    }
  }

  void _populateFields() {
    final address = widget.addressToEdit!;
    _addressTitleController.text = address.title;
    _streetNameController.text = address.streetName;
    _buildingNumberController.text = address.buildingNumber;
    _floorController.text = address.floor;
    _apartmentController.text = address.apartment;
    _cityController.text = address.cityId;
    _countryController.text = address.country;
    _areaController.text = address.areaId;
    _postalCodeController.text = address.cityPostalCode;
  }

  @override
  void dispose() {
    _addressTitleController.dispose();
    _streetNameController.dispose();
    _buildingNumberController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _areaController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final address = Address(
          title: _addressTitleController.text.trim(),
          streetName: _streetNameController.text.trim(),
          buildingNumber: _buildingNumberController.text.trim(),
          floor: _floorController.text.trim(),
          apartment: _apartmentController.text.trim(),
          areaId: _areaController.text.trim(),
          cityId: _cityController.text.trim(),
          country: _countryController.text.trim(),
          cityPostalCode: _postalCodeController.text.trim(),
          id: widget.addressToEdit?.id,
        );

        bool success;
        if (widget.addressToEdit != null) {
          // Update existing address
          success = await AddressService.updateAddress(address);
        } else {
          // Save new address
          success = await AddressService.saveAddress(address);
        }

        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.addressToEdit != null
                  ? 'Address updated successfully'
                  : 'Address saved successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true);
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save address'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save address: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.addressToEdit != null ? 'Edit Address' : 'Add Address',
        titleIcon: Icons.location_on_outlined,
        backgroundColor: AppTheme.primaryColor,
        titleColor: AppTheme.textColor,
        horizontalPadding: 16.0,
        showLogo: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Address Title
                _buildTextField(
                  controller: _addressTitleController,
                  label: 'Address Title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address title';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Street Name & Building Number (Row)
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildTextField(
                        controller: _streetNameController,
                        label: 'Street Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter street name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: _buildTextField(
                        controller: _buildingNumberController,
                        label: 'Building No.',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Floor & Apartment (Row)
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _floorController,
                        label: 'Floor',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter floor';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _apartmentController,
                        label: 'Apartment',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter apartment';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // City ID
                _buildTextField(
                  controller: _cityController,
                  label: 'City ID',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city ID';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Country
                _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter country';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Area ID
                _buildTextField(
                  controller: _areaController,
                  label: 'Area ID',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter area ID';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // City Postal Code
                _buildTextField(
                  controller: _postalCodeController,
                  label: 'City Postal Code',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city postal code';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _handleCancel,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppTheme.textColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: 'Save Address',
                        onPressed: _handleSave,
                        isLoading: _isLoading,
                        height: 48,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.textColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.textColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.textColor, width: 2),
        ),
        labelStyle: TextStyle(color: AppTheme.textColor),
      ),
      validator: validator,
    );
  }
}
