import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required String title,
    required String streetName,
    required String buildingNumber,
    required String floor,
    required String apartment,
    required String areaId,
    required String cityId,
    required String country,
    required String cityPostalCode,
    String? id, // For local identification
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
