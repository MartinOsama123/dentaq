// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as String?,
      name: fields[1] as String?,
      slug: fields[2] as String?,
      price: fields[3] as double?,
      quantity: fields[4] as int?,
      category: fields[5] as Category?,
      images: (fields[6] as List?)?.cast<String>(),
      specs: (fields[7] as List?)?.cast<Spec>(),
      description: fields[8] as String?,
      manufacturer: fields[9] as String?,
      brand: fields[10] as String?,
      barcode: fields[11] as String?,
      thumbnail: fields[12] as String?,
      hasVariants: fields[13] as bool?,
      isVariant: fields[14] as bool?,
      variants: (fields[15] as List?)?.cast<String>(),
      variantOf: fields[16] as String?,
      variantSpec: fields[17] as String?,
      details: (fields[18] as List?)?.cast<dynamic>(),
      size: fields[19] as ProductSize?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.specs)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.manufacturer)
      ..writeByte(10)
      ..write(obj.brand)
      ..writeByte(11)
      ..write(obj.barcode)
      ..writeByte(12)
      ..write(obj.thumbnail)
      ..writeByte(13)
      ..write(obj.hasVariants)
      ..writeByte(14)
      ..write(obj.isVariant)
      ..writeByte(15)
      ..write(obj.variants)
      ..writeByte(16)
      ..write(obj.variantOf)
      ..writeByte(17)
      ..write(obj.variantSpec)
      ..writeByte(18)
      ..write(obj.details)
      ..writeByte(19)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      id: fields[0] as String?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      parentId: fields[3] as String?,
      level: fields[4] as int?,
      slug: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.parentId)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.slug);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecAdapter extends TypeAdapter<Spec> {
  @override
  final int typeId = 2;

  @override
  Spec read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spec(
      name: fields[0] as String?,
      value: (fields[1] as List?)?.cast<String>(),
      id: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Spec obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductSizeAdapter extends TypeAdapter<ProductSize> {
  @override
  final int typeId = 3;

  @override
  ProductSize read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductSize(
      weight: fields[0] as double?,
      length: fields[1] as double?,
      width: fields[2] as double?,
      height: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductSize obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.weight)
      ..writeByte(1)
      ..write(obj.length)
      ..writeByte(2)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      specs: (json['specs'] as List<dynamic>?)
          ?.map((e) => Spec.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      manufacturer: json['manufacturer'] as String?,
      brand: json['brand'] as String?,
      barcode: json['barcode'] as String?,
      thumbnail: json['thumbnail'] as String?,
      hasVariants: json['hasVariants'] as bool?,
      isVariant: json['isVariant'] as bool?,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      variantOf: json['variantOf'] as String?,
      variantSpec: json['variantSpec'] as String?,
      details: json['details'] as List<dynamic>?,
      size: json['size'] == null
          ? null
          : ProductSize.fromJson(json['size'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'price': instance.price,
      'quantity': instance.quantity,
      'category': instance.category,
      'images': instance.images,
      'specs': instance.specs,
      'description': instance.description,
      'manufacturer': instance.manufacturer,
      'brand': instance.brand,
      'barcode': instance.barcode,
      'thumbnail': instance.thumbnail,
      'hasVariants': instance.hasVariants,
      'isVariant': instance.isVariant,
      'variants': instance.variants,
      'variantOf': instance.variantOf,
      'variantSpec': instance.variantSpec,
      'details': instance.details,
      'size': instance.size,
    };

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
      level: (json['level'] as num?)?.toInt(),
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'level': instance.level,
      'slug': instance.slug,
    };

_$SpecImpl _$$SpecImplFromJson(Map<String, dynamic> json) => _$SpecImpl(
      name: json['name'] as String?,
      value:
          (json['value'] as List<dynamic>?)?.map((e) => e as String).toList(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$$SpecImplToJson(_$SpecImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      '_id': instance.id,
    };

_$ProductSizeImpl _$$ProductSizeImplFromJson(Map<String, dynamic> json) =>
    _$ProductSizeImpl(
      weight: (json['weight'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ProductSizeImplToJson(_$ProductSizeImpl instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
    };
