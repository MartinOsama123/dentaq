// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      title: json['title'] as String,
      streetName: json['streetName'] as String,
      buildingNumber: json['buildingNumber'] as String,
      floor: json['floor'] as String,
      apartment: json['apartment'] as String,
      areaId: json['areaId'] as String,
      cityId: json['cityId'] as String,
      country: json['country'] as String,
      cityPostalCode: json['cityPostalCode'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'streetName': instance.streetName,
      'buildingNumber': instance.buildingNumber,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'areaId': instance.areaId,
      'cityId': instance.cityId,
      'country': instance.country,
      'cityPostalCode': instance.cityPostalCode,
      'id': instance.id,
    };
