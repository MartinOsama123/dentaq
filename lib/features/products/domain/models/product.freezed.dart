// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  @HiveField(0)
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get slug => throw _privateConstructorUsedError;
  @HiveField(3)
  double? get price => throw _privateConstructorUsedError;
  @HiveField(4)
  int? get quantity => throw _privateConstructorUsedError;
  @HiveField(5)
  Category? get category => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String>? get images => throw _privateConstructorUsedError;
  @HiveField(7)
  List<Spec>? get specs => throw _privateConstructorUsedError;
  @HiveField(8)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get manufacturer => throw _privateConstructorUsedError;
  @HiveField(10)
  String? get brand => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get barcode => throw _privateConstructorUsedError;
  @HiveField(12)
  String? get thumbnail => throw _privateConstructorUsedError;
  @HiveField(13)
  bool? get hasVariants => throw _privateConstructorUsedError;
  @HiveField(14)
  bool? get isVariant => throw _privateConstructorUsedError;
  @HiveField(15)
  List<String>? get variants => throw _privateConstructorUsedError;
  @HiveField(16)
  String? get variantOf => throw _privateConstructorUsedError;
  @HiveField(17)
  String? get variantSpec => throw _privateConstructorUsedError;
  @HiveField(18)
  List<dynamic>? get details => throw _privateConstructorUsedError;
  @HiveField(19)
  ProductSize? get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: '_id') String? id,
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
      @HiveField(19) ProductSize? size});

  $CategoryCopyWith<$Res>? get category;
  $ProductSizeCopyWith<$Res>? get size;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? price = freezed,
    Object? quantity = freezed,
    Object? category = freezed,
    Object? images = freezed,
    Object? specs = freezed,
    Object? description = freezed,
    Object? manufacturer = freezed,
    Object? brand = freezed,
    Object? barcode = freezed,
    Object? thumbnail = freezed,
    Object? hasVariants = freezed,
    Object? isVariant = freezed,
    Object? variants = freezed,
    Object? variantOf = freezed,
    Object? variantSpec = freezed,
    Object? details = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      specs: freezed == specs
          ? _value.specs
          : specs // ignore: cast_nullable_to_non_nullable
              as List<Spec>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      hasVariants: freezed == hasVariants
          ? _value.hasVariants
          : hasVariants // ignore: cast_nullable_to_non_nullable
              as bool?,
      isVariant: freezed == isVariant
          ? _value.isVariant
          : isVariant // ignore: cast_nullable_to_non_nullable
              as bool?,
      variants: freezed == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      variantOf: freezed == variantOf
          ? _value.variantOf
          : variantOf // ignore: cast_nullable_to_non_nullable
              as String?,
      variantSpec: freezed == variantSpec
          ? _value.variantSpec
          : variantSpec // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as ProductSize?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductSizeCopyWith<$Res>? get size {
    if (_value.size == null) {
      return null;
    }

    return $ProductSizeCopyWith<$Res>(_value.size!, (value) {
      return _then(_value.copyWith(size: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: '_id') String? id,
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
      @HiveField(19) ProductSize? size});

  @override
  $CategoryCopyWith<$Res>? get category;
  @override
  $ProductSizeCopyWith<$Res>? get size;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? price = freezed,
    Object? quantity = freezed,
    Object? category = freezed,
    Object? images = freezed,
    Object? specs = freezed,
    Object? description = freezed,
    Object? manufacturer = freezed,
    Object? brand = freezed,
    Object? barcode = freezed,
    Object? thumbnail = freezed,
    Object? hasVariants = freezed,
    Object? isVariant = freezed,
    Object? variants = freezed,
    Object? variantOf = freezed,
    Object? variantSpec = freezed,
    Object? details = freezed,
    Object? size = freezed,
  }) {
    return _then(_$ProductImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      specs: freezed == specs
          ? _value._specs
          : specs // ignore: cast_nullable_to_non_nullable
              as List<Spec>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      hasVariants: freezed == hasVariants
          ? _value.hasVariants
          : hasVariants // ignore: cast_nullable_to_non_nullable
              as bool?,
      isVariant: freezed == isVariant
          ? _value.isVariant
          : isVariant // ignore: cast_nullable_to_non_nullable
              as bool?,
      variants: freezed == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      variantOf: freezed == variantOf
          ? _value.variantOf
          : variantOf // ignore: cast_nullable_to_non_nullable
              as String?,
      variantSpec: freezed == variantSpec
          ? _value.variantSpec
          : variantSpec // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value._details
          : details // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as ProductSize?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {@HiveField(0) @JsonKey(name: '_id') this.id,
      @HiveField(1) this.name,
      @HiveField(2) this.slug,
      @HiveField(3) this.price,
      @HiveField(4) this.quantity,
      @HiveField(5) this.category,
      @HiveField(6) final List<String>? images,
      @HiveField(7) final List<Spec>? specs,
      @HiveField(8) this.description,
      @HiveField(9) this.manufacturer,
      @HiveField(10) this.brand,
      @HiveField(11) this.barcode,
      @HiveField(12) this.thumbnail,
      @HiveField(13) this.hasVariants,
      @HiveField(14) this.isVariant,
      @HiveField(15) final List<String>? variants,
      @HiveField(16) this.variantOf,
      @HiveField(17) this.variantSpec,
      @HiveField(18) final List<dynamic>? details,
      @HiveField(19) this.size})
      : _images = images,
        _specs = specs,
        _variants = variants,
        _details = details;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: '_id')
  final String? id;
  @override
  @HiveField(1)
  final String? name;
  @override
  @HiveField(2)
  final String? slug;
  @override
  @HiveField(3)
  final double? price;
  @override
  @HiveField(4)
  final int? quantity;
  @override
  @HiveField(5)
  final Category? category;
  final List<String>? _images;
  @override
  @HiveField(6)
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Spec>? _specs;
  @override
  @HiveField(7)
  List<Spec>? get specs {
    final value = _specs;
    if (value == null) return null;
    if (_specs is EqualUnmodifiableListView) return _specs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(8)
  final String? description;
  @override
  @HiveField(9)
  final String? manufacturer;
  @override
  @HiveField(10)
  final String? brand;
  @override
  @HiveField(11)
  final String? barcode;
  @override
  @HiveField(12)
  final String? thumbnail;
  @override
  @HiveField(13)
  final bool? hasVariants;
  @override
  @HiveField(14)
  final bool? isVariant;
  final List<String>? _variants;
  @override
  @HiveField(15)
  List<String>? get variants {
    final value = _variants;
    if (value == null) return null;
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(16)
  final String? variantOf;
  @override
  @HiveField(17)
  final String? variantSpec;
  final List<dynamic>? _details;
  @override
  @HiveField(18)
  List<dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableListView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(19)
  final ProductSize? size;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, slug: $slug, price: $price, quantity: $quantity, category: $category, images: $images, specs: $specs, description: $description, manufacturer: $manufacturer, brand: $brand, barcode: $barcode, thumbnail: $thumbnail, hasVariants: $hasVariants, isVariant: $isVariant, variants: $variants, variantOf: $variantOf, variantSpec: $variantSpec, details: $details, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality().equals(other._specs, _specs) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.hasVariants, hasVariants) ||
                other.hasVariants == hasVariants) &&
            (identical(other.isVariant, isVariant) ||
                other.isVariant == isVariant) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.variantOf, variantOf) ||
                other.variantOf == variantOf) &&
            (identical(other.variantSpec, variantSpec) ||
                other.variantSpec == variantSpec) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        slug,
        price,
        quantity,
        category,
        const DeepCollectionEquality().hash(_images),
        const DeepCollectionEquality().hash(_specs),
        description,
        manufacturer,
        brand,
        barcode,
        thumbnail,
        hasVariants,
        isVariant,
        const DeepCollectionEquality().hash(_variants),
        variantOf,
        variantSpec,
        const DeepCollectionEquality().hash(_details),
        size
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {@HiveField(0) @JsonKey(name: '_id') final String? id,
      @HiveField(1) final String? name,
      @HiveField(2) final String? slug,
      @HiveField(3) final double? price,
      @HiveField(4) final int? quantity,
      @HiveField(5) final Category? category,
      @HiveField(6) final List<String>? images,
      @HiveField(7) final List<Spec>? specs,
      @HiveField(8) final String? description,
      @HiveField(9) final String? manufacturer,
      @HiveField(10) final String? brand,
      @HiveField(11) final String? barcode,
      @HiveField(12) final String? thumbnail,
      @HiveField(13) final bool? hasVariants,
      @HiveField(14) final bool? isVariant,
      @HiveField(15) final List<String>? variants,
      @HiveField(16) final String? variantOf,
      @HiveField(17) final String? variantSpec,
      @HiveField(18) final List<dynamic>? details,
      @HiveField(19) final ProductSize? size}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  @HiveField(0)
  @JsonKey(name: '_id')
  String? get id;
  @override
  @HiveField(1)
  String? get name;
  @override
  @HiveField(2)
  String? get slug;
  @override
  @HiveField(3)
  double? get price;
  @override
  @HiveField(4)
  int? get quantity;
  @override
  @HiveField(5)
  Category? get category;
  @override
  @HiveField(6)
  List<String>? get images;
  @override
  @HiveField(7)
  List<Spec>? get specs;
  @override
  @HiveField(8)
  String? get description;
  @override
  @HiveField(9)
  String? get manufacturer;
  @override
  @HiveField(10)
  String? get brand;
  @override
  @HiveField(11)
  String? get barcode;
  @override
  @HiveField(12)
  String? get thumbnail;
  @override
  @HiveField(13)
  bool? get hasVariants;
  @override
  @HiveField(14)
  bool? get isVariant;
  @override
  @HiveField(15)
  List<String>? get variants;
  @override
  @HiveField(16)
  String? get variantOf;
  @override
  @HiveField(17)
  String? get variantSpec;
  @override
  @HiveField(18)
  List<dynamic>? get details;
  @override
  @HiveField(19)
  ProductSize? get size;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  @HiveField(0)
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get parentId => throw _privateConstructorUsedError;
  @HiveField(4)
  int? get level => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get slug => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: '_id') String? id,
      @HiveField(1) String? name,
      @HiveField(2) String? description,
      @HiveField(3) String? parentId,
      @HiveField(4) int? level,
      @HiveField(5) String? slug});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
    Object? slug = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
          _$CategoryImpl value, $Res Function(_$CategoryImpl) then) =
      __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: '_id') String? id,
      @HiveField(1) String? name,
      @HiveField(2) String? description,
      @HiveField(3) String? parentId,
      @HiveField(4) int? level,
      @HiveField(5) String? slug});
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
      _$CategoryImpl _value, $Res Function(_$CategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? parentId = freezed,
    Object? level = freezed,
    Object? slug = freezed,
  }) {
    return _then(_$CategoryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl implements _Category {
  const _$CategoryImpl(
      {@HiveField(0) @JsonKey(name: '_id') this.id,
      @HiveField(1) this.name,
      @HiveField(2) this.description,
      @HiveField(3) this.parentId,
      @HiveField(4) this.level,
      @HiveField(5) this.slug});

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: '_id')
  final String? id;
  @override
  @HiveField(1)
  final String? name;
  @override
  @HiveField(2)
  final String? description;
  @override
  @HiveField(3)
  final String? parentId;
  @override
  @HiveField(4)
  final int? level;
  @override
  @HiveField(5)
  final String? slug;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, parentId: $parentId, level: $level, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, parentId, level, slug);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(
      this,
    );
  }
}

abstract class _Category implements Category {
  const factory _Category(
      {@HiveField(0) @JsonKey(name: '_id') final String? id,
      @HiveField(1) final String? name,
      @HiveField(2) final String? description,
      @HiveField(3) final String? parentId,
      @HiveField(4) final int? level,
      @HiveField(5) final String? slug}) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  @HiveField(0)
  @JsonKey(name: '_id')
  String? get id;
  @override
  @HiveField(1)
  String? get name;
  @override
  @HiveField(2)
  String? get description;
  @override
  @HiveField(3)
  String? get parentId;
  @override
  @HiveField(4)
  int? get level;
  @override
  @HiveField(5)
  String? get slug;
  @override
  @JsonKey(ignore: true)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Spec _$SpecFromJson(Map<String, dynamic> json) {
  return _Spec.fromJson(json);
}

/// @nodoc
mixin _$Spec {
  @HiveField(0)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(1)
  List<String>? get value => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpecCopyWith<Spec> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecCopyWith<$Res> {
  factory $SpecCopyWith(Spec value, $Res Function(Spec) then) =
      _$SpecCopyWithImpl<$Res, Spec>;
  @useResult
  $Res call(
      {@HiveField(0) String? name,
      @HiveField(1) List<String>? value,
      @HiveField(2) @JsonKey(name: '_id') String? id});
}

/// @nodoc
class _$SpecCopyWithImpl<$Res, $Val extends Spec>
    implements $SpecCopyWith<$Res> {
  _$SpecCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpecImplCopyWith<$Res> implements $SpecCopyWith<$Res> {
  factory _$$SpecImplCopyWith(
          _$SpecImpl value, $Res Function(_$SpecImpl) then) =
      __$$SpecImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String? name,
      @HiveField(1) List<String>? value,
      @HiveField(2) @JsonKey(name: '_id') String? id});
}

/// @nodoc
class __$$SpecImplCopyWithImpl<$Res>
    extends _$SpecCopyWithImpl<$Res, _$SpecImpl>
    implements _$$SpecImplCopyWith<$Res> {
  __$$SpecImplCopyWithImpl(_$SpecImpl _value, $Res Function(_$SpecImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? value = freezed,
    Object? id = freezed,
  }) {
    return _then(_$SpecImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpecImpl implements _Spec {
  const _$SpecImpl(
      {@HiveField(0) this.name,
      @HiveField(1) final List<String>? value,
      @HiveField(2) @JsonKey(name: '_id') this.id})
      : _value = value;

  factory _$SpecImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecImplFromJson(json);

  @override
  @HiveField(0)
  final String? name;
  final List<String>? _value;
  @override
  @HiveField(1)
  List<String>? get value {
    final value = _value;
    if (value == null) return null;
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(2)
  @JsonKey(name: '_id')
  final String? id;

  @override
  String toString() {
    return 'Spec(name: $name, value: $value, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._value, _value) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_value), id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecImplCopyWith<_$SpecImpl> get copyWith =>
      __$$SpecImplCopyWithImpl<_$SpecImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecImplToJson(
      this,
    );
  }
}

abstract class _Spec implements Spec {
  const factory _Spec(
      {@HiveField(0) final String? name,
      @HiveField(1) final List<String>? value,
      @HiveField(2) @JsonKey(name: '_id') final String? id}) = _$SpecImpl;

  factory _Spec.fromJson(Map<String, dynamic> json) = _$SpecImpl.fromJson;

  @override
  @HiveField(0)
  String? get name;
  @override
  @HiveField(1)
  List<String>? get value;
  @override
  @HiveField(2)
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$SpecImplCopyWith<_$SpecImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductSize _$ProductSizeFromJson(Map<String, dynamic> json) {
  return _ProductSize.fromJson(json);
}

/// @nodoc
mixin _$ProductSize {
  @HiveField(0)
  double? get weight => throw _privateConstructorUsedError;
  @HiveField(1)
  double? get length => throw _privateConstructorUsedError;
  @HiveField(2)
  double? get width => throw _privateConstructorUsedError;
  @HiveField(3)
  double? get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductSizeCopyWith<ProductSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSizeCopyWith<$Res> {
  factory $ProductSizeCopyWith(
          ProductSize value, $Res Function(ProductSize) then) =
      _$ProductSizeCopyWithImpl<$Res, ProductSize>;
  @useResult
  $Res call(
      {@HiveField(0) double? weight,
      @HiveField(1) double? length,
      @HiveField(2) double? width,
      @HiveField(3) double? height});
}

/// @nodoc
class _$ProductSizeCopyWithImpl<$Res, $Val extends ProductSize>
    implements $ProductSizeCopyWith<$Res> {
  _$ProductSizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = freezed,
    Object? length = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductSizeImplCopyWith<$Res>
    implements $ProductSizeCopyWith<$Res> {
  factory _$$ProductSizeImplCopyWith(
          _$ProductSizeImpl value, $Res Function(_$ProductSizeImpl) then) =
      __$$ProductSizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double? weight,
      @HiveField(1) double? length,
      @HiveField(2) double? width,
      @HiveField(3) double? height});
}

/// @nodoc
class __$$ProductSizeImplCopyWithImpl<$Res>
    extends _$ProductSizeCopyWithImpl<$Res, _$ProductSizeImpl>
    implements _$$ProductSizeImplCopyWith<$Res> {
  __$$ProductSizeImplCopyWithImpl(
      _$ProductSizeImpl _value, $Res Function(_$ProductSizeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = freezed,
    Object? length = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(_$ProductSizeImpl(
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      length: freezed == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductSizeImpl implements _ProductSize {
  const _$ProductSizeImpl(
      {@HiveField(0) this.weight,
      @HiveField(1) this.length,
      @HiveField(2) this.width,
      @HiveField(3) this.height});

  factory _$ProductSizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductSizeImplFromJson(json);

  @override
  @HiveField(0)
  final double? weight;
  @override
  @HiveField(1)
  final double? length;
  @override
  @HiveField(2)
  final double? width;
  @override
  @HiveField(3)
  final double? height;

  @override
  String toString() {
    return 'ProductSize(weight: $weight, length: $length, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductSizeImpl &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, weight, length, width, height);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductSizeImplCopyWith<_$ProductSizeImpl> get copyWith =>
      __$$ProductSizeImplCopyWithImpl<_$ProductSizeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductSizeImplToJson(
      this,
    );
  }
}

abstract class _ProductSize implements ProductSize {
  const factory _ProductSize(
      {@HiveField(0) final double? weight,
      @HiveField(1) final double? length,
      @HiveField(2) final double? width,
      @HiveField(3) final double? height}) = _$ProductSizeImpl;

  factory _ProductSize.fromJson(Map<String, dynamic> json) =
      _$ProductSizeImpl.fromJson;

  @override
  @HiveField(0)
  double? get weight;
  @override
  @HiveField(1)
  double? get length;
  @override
  @HiveField(2)
  double? get width;
  @override
  @HiveField(3)
  double? get height;
  @override
  @JsonKey(ignore: true)
  _$$ProductSizeImplCopyWith<_$ProductSizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
