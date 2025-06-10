import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/address.dart';

class AddressService {
  static const String _addressKey = 'user_addresses';

  static Future<List<Address>> getAddresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final addressesJson = prefs.getString(_addressKey);

      if (addressesJson == null) return [];

      final Map<String, dynamic> data = json.decode(addressesJson);
      final List<dynamic> addressList = data['address'] ?? [];

      return addressList
          .map((addressJson) =>
              Address.fromJson(addressJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<bool> saveAddress(Address address) async {
    try {
      final addresses = await getAddresses();

      // Add unique ID if not present
      final addressWithId = address.copyWith(
        id: address.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      );

      addresses.add(addressWithId);
      return await _saveAddresses(addresses);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateAddress(Address updatedAddress) async {
    try {
      final addresses = await getAddresses();
      final index =
          addresses.indexWhere((addr) => addr.id == updatedAddress.id);

      if (index == -1) return false;

      addresses[index] = updatedAddress;
      return await _saveAddresses(addresses);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteAddress(String addressId) async {
    try {
      final addresses = await getAddresses();
      addresses.removeWhere((addr) => addr.id == addressId);
      return await _saveAddresses(addresses);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> _saveAddresses(List<Address> addresses) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = {
        'address': addresses.map((addr) => addr.toJson()).toList(),
      };

      await prefs.setString(_addressKey, json.encode(data));
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> clearAddresses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_addressKey);
    } catch (e) {
      // Ignore errors when clearing
    }
  }
}
