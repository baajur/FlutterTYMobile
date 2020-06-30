// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'failure_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$FailureCodeTearOff {
  const _$FailureCodeTearOff();

  _FailureCode call(
      {FailureTypeCode typeCode = FailureTypeCode.NOT_DEFINED, int code = 0}) {
    return _FailureCode(
      typeCode: typeCode,
      code: code,
    );
  }
}

// ignore: unused_element
const $FailureCode = _$FailureCodeTearOff();

mixin _$FailureCode {
  FailureTypeCode get typeCode;
  int get code;

  $FailureCodeCopyWith<FailureCode> get copyWith;
}

abstract class $FailureCodeCopyWith<$Res> {
  factory $FailureCodeCopyWith(
          FailureCode value, $Res Function(FailureCode) then) =
      _$FailureCodeCopyWithImpl<$Res>;
  $Res call({FailureTypeCode typeCode, int code});
}

class _$FailureCodeCopyWithImpl<$Res> implements $FailureCodeCopyWith<$Res> {
  _$FailureCodeCopyWithImpl(this._value, this._then);

  final FailureCode _value;
  // ignore: unused_field
  final $Res Function(FailureCode) _then;

  @override
  $Res call({
    Object typeCode = freezed,
    Object code = freezed,
  }) {
    return _then(_value.copyWith(
      typeCode:
          typeCode == freezed ? _value.typeCode : typeCode as FailureTypeCode,
      code: code == freezed ? _value.code : code as int,
    ));
  }
}

abstract class _$FailureCodeCopyWith<$Res>
    implements $FailureCodeCopyWith<$Res> {
  factory _$FailureCodeCopyWith(
          _FailureCode value, $Res Function(_FailureCode) then) =
      __$FailureCodeCopyWithImpl<$Res>;
  @override
  $Res call({FailureTypeCode typeCode, int code});
}

class __$FailureCodeCopyWithImpl<$Res> extends _$FailureCodeCopyWithImpl<$Res>
    implements _$FailureCodeCopyWith<$Res> {
  __$FailureCodeCopyWithImpl(
      _FailureCode _value, $Res Function(_FailureCode) _then)
      : super(_value, (v) => _then(v as _FailureCode));

  @override
  _FailureCode get _value => super._value as _FailureCode;

  @override
  $Res call({
    Object typeCode = freezed,
    Object code = freezed,
  }) {
    return _then(_FailureCode(
      typeCode:
          typeCode == freezed ? _value.typeCode : typeCode as FailureTypeCode,
      code: code == freezed ? _value.code : code as int,
    ));
  }
}

class _$_FailureCode implements _FailureCode {
  _$_FailureCode({this.typeCode = FailureTypeCode.NOT_DEFINED, this.code = 0})
      : assert(typeCode != null),
        assert(code != null);

  @JsonKey(defaultValue: FailureTypeCode.NOT_DEFINED)
  @override
  final FailureTypeCode typeCode;
  @JsonKey(defaultValue: 0)
  @override
  final int code;

  bool _diderrorCode = false;
  int _errorCode;

  @override
  int get errorCode {
    if (_diderrorCode == false) {
      _diderrorCode = true;
      _errorCode = typeCode.value + code;
    }
    return _errorCode;
  }

  @override
  String toString() {
    return 'FailureCode(typeCode: $typeCode, code: $code, errorCode: $errorCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FailureCode &&
            (identical(other.typeCode, typeCode) ||
                const DeepCollectionEquality()
                    .equals(other.typeCode, typeCode)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(typeCode) ^
      const DeepCollectionEquality().hash(code);

  @override
  _$FailureCodeCopyWith<_FailureCode> get copyWith =>
      __$FailureCodeCopyWithImpl<_FailureCode>(this, _$identity);
}

abstract class _FailureCode implements FailureCode {
  factory _FailureCode({FailureTypeCode typeCode, int code}) = _$_FailureCode;

  @override
  FailureTypeCode get typeCode;
  @override
  int get code;
  @override
  _$FailureCodeCopyWith<_FailureCode> get copyWith;
}
