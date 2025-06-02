import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
@HiveType(typeId: 0)
class Product with _$Product {
  const factory Product({
    @HiveField(0) @JsonKey(name: '_id') String? id,
    @HiveField(1) String? name,
    @HiveField(2) String? slug,
    @HiveField(3) double? price,
    @HiveField(4) int? quantity,
    @HiveField(5) Category? category,
    @HiveField(6) List<String>? images,
    @HiveField(7) List<Spec>? specs,
    @HiveField(8) String? description,
    @HiveField(9) String? manufacturer,
    @HiveField(10) String? brand,
    @HiveField(11) String? barcode,
    @HiveField(12) String? thumbnail,
    @HiveField(13) bool? hasVariants,
    @HiveField(14) bool? isVariant,
    @HiveField(15) List<String>? variants,
    @HiveField(16) String? variantOf,
    @HiveField(17) String? variantSpec,
    @HiveField(18) List<dynamic>? details,
    @HiveField(19) ProductSize? size,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
@HiveType(typeId: 1)
class Category with _$Category {
  const factory Category({
    @HiveField(0) @JsonKey(name: '_id') String? id,
    @HiveField(1) String? name,
    @HiveField(2) String? description,
    @HiveField(3) String? parentId,
    @HiveField(4) int? level,
    @HiveField(5) String? slug,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
@HiveType(typeId: 2)
class Spec with _$Spec {
  const factory Spec({
    @HiveField(0) String? name,
    @HiveField(1) List<String>? value,
    @HiveField(2) @JsonKey(name: '_id') String? id,
  }) = _Spec;

  factory Spec.fromJson(Map<String, dynamic> json) => _$SpecFromJson(json);
}

@freezed
@HiveType(typeId: 3)
class ProductSize with _$ProductSize {
  const factory ProductSize({
    @HiveField(0) double? weight,
    @HiveField(1) double? length,
    @HiveField(2) double? width,
    @HiveField(3) double? height,
  }) = _ProductSize;

  factory ProductSize.fromJson(Map<String, dynamic> json) =>
      _$ProductSizeFromJson(json);
}
