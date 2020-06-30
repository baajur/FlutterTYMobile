// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'store_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$StoreProductModelTearOff {
  const _$StoreProductModelTearOff();

  _StoreProductModel call(
      {@JsonKey(name: 'productid', defaultValue: -1) int productId,
      @JsonKey(name: 'productname', defaultValue: '?') String productName,
      num point,
      @JsonKey(name: 'sequence') int remain,
      int pic,
      @JsonKey(name: 'new') String isNew}) {
    return _StoreProductModel(
      productId: productId,
      productName: productName,
      point: point,
      remain: remain,
      pic: pic,
      isNew: isNew,
    );
  }
}

// ignore: unused_element
const $StoreProductModel = _$StoreProductModelTearOff();

mixin _$StoreProductModel {
  @JsonKey(name: 'productid', defaultValue: -1)
  int get productId;
  @JsonKey(name: 'productname', defaultValue: '?')
  String get productName;
  num get point;
  @JsonKey(name: 'sequence')
  int get remain;
  int get pic;
  @JsonKey(name: 'new')
  String get isNew;

  $StoreProductModelCopyWith<StoreProductModel> get copyWith;
}

abstract class $StoreProductModelCopyWith<$Res> {
  factory $StoreProductModelCopyWith(
          StoreProductModel value, $Res Function(StoreProductModel) then) =
      _$StoreProductModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'productid', defaultValue: -1) int productId,
      @JsonKey(name: 'productname', defaultValue: '?') String productName,
      num point,
      @JsonKey(name: 'sequence') int remain,
      int pic,
      @JsonKey(name: 'new') String isNew});
}

class _$StoreProductModelCopyWithImpl<$Res>
    implements $StoreProductModelCopyWith<$Res> {
  _$StoreProductModelCopyWithImpl(this._value, this._then);

  final StoreProductModel _value;
  // ignore: unused_field
  final $Res Function(StoreProductModel) _then;

  @override
  $Res call({
    Object productId = freezed,
    Object productName = freezed,
    Object point = freezed,
    Object remain = freezed,
    Object pic = freezed,
    Object isNew = freezed,
  }) {
    return _then(_value.copyWith(
      productId: productId == freezed ? _value.productId : productId as int,
      productName:
          productName == freezed ? _value.productName : productName as String,
      point: point == freezed ? _value.point : point as num,
      remain: remain == freezed ? _value.remain : remain as int,
      pic: pic == freezed ? _value.pic : pic as int,
      isNew: isNew == freezed ? _value.isNew : isNew as String,
    ));
  }
}

abstract class _$StoreProductModelCopyWith<$Res>
    implements $StoreProductModelCopyWith<$Res> {
  factory _$StoreProductModelCopyWith(
          _StoreProductModel value, $Res Function(_StoreProductModel) then) =
      __$StoreProductModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'productid', defaultValue: -1) int productId,
      @JsonKey(name: 'productname', defaultValue: '?') String productName,
      num point,
      @JsonKey(name: 'sequence') int remain,
      int pic,
      @JsonKey(name: 'new') String isNew});
}

class __$StoreProductModelCopyWithImpl<$Res>
    extends _$StoreProductModelCopyWithImpl<$Res>
    implements _$StoreProductModelCopyWith<$Res> {
  __$StoreProductModelCopyWithImpl(
      _StoreProductModel _value, $Res Function(_StoreProductModel) _then)
      : super(_value, (v) => _then(v as _StoreProductModel));

  @override
  _StoreProductModel get _value => super._value as _StoreProductModel;

  @override
  $Res call({
    Object productId = freezed,
    Object productName = freezed,
    Object point = freezed,
    Object remain = freezed,
    Object pic = freezed,
    Object isNew = freezed,
  }) {
    return _then(_StoreProductModel(
      productId: productId == freezed ? _value.productId : productId as int,
      productName:
          productName == freezed ? _value.productName : productName as String,
      point: point == freezed ? _value.point : point as num,
      remain: remain == freezed ? _value.remain : remain as int,
      pic: pic == freezed ? _value.pic : pic as int,
      isNew: isNew == freezed ? _value.isNew : isNew as String,
    ));
  }
}

class _$_StoreProductModel implements _StoreProductModel {
  const _$_StoreProductModel(
      {@JsonKey(name: 'productid', defaultValue: -1) this.productId,
      @JsonKey(name: 'productname', defaultValue: '?') this.productName,
      this.point,
      @JsonKey(name: 'sequence') this.remain,
      this.pic,
      @JsonKey(name: 'new') this.isNew});

  @override
  @JsonKey(name: 'productid', defaultValue: -1)
  final int productId;
  @override
  @JsonKey(name: 'productname', defaultValue: '?')
  final String productName;
  @override
  final num point;
  @override
  @JsonKey(name: 'sequence')
  final int remain;
  @override
  final int pic;
  @override
  @JsonKey(name: 'new')
  final String isNew;

  @override
  String toString() {
    return 'StoreProductModel(productId: $productId, productName: $productName, point: $point, remain: $remain, pic: $pic, isNew: $isNew)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StoreProductModel &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality()
                    .equals(other.productId, productId)) &&
            (identical(other.productName, productName) ||
                const DeepCollectionEquality()
                    .equals(other.productName, productName)) &&
            (identical(other.point, point) ||
                const DeepCollectionEquality().equals(other.point, point)) &&
            (identical(other.remain, remain) ||
                const DeepCollectionEquality().equals(other.remain, remain)) &&
            (identical(other.pic, pic) ||
                const DeepCollectionEquality().equals(other.pic, pic)) &&
            (identical(other.isNew, isNew) ||
                const DeepCollectionEquality().equals(other.isNew, isNew)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(productName) ^
      const DeepCollectionEquality().hash(point) ^
      const DeepCollectionEquality().hash(remain) ^
      const DeepCollectionEquality().hash(pic) ^
      const DeepCollectionEquality().hash(isNew);

  @override
  _$StoreProductModelCopyWith<_StoreProductModel> get copyWith =>
      __$StoreProductModelCopyWithImpl<_StoreProductModel>(this, _$identity);
}

abstract class _StoreProductModel implements StoreProductModel {
  const factory _StoreProductModel(
      {@JsonKey(name: 'productid', defaultValue: -1) int productId,
      @JsonKey(name: 'productname', defaultValue: '?') String productName,
      num point,
      @JsonKey(name: 'sequence') int remain,
      int pic,
      @JsonKey(name: 'new') String isNew}) = _$_StoreProductModel;

  @override
  @JsonKey(name: 'productid', defaultValue: -1)
  int get productId;
  @override
  @JsonKey(name: 'productname', defaultValue: '?')
  String get productName;
  @override
  num get point;
  @override
  @JsonKey(name: 'sequence')
  int get remain;
  @override
  int get pic;
  @override
  @JsonKey(name: 'new')
  String get isNew;
  @override
  _$StoreProductModelCopyWith<_StoreProductModel> get copyWith;
}
