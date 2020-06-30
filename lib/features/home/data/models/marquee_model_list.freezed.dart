// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'marquee_model_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$MarqueeModelListTearOff {
  const _$MarqueeModelListTearOff();

  _MarqueeModelList call(
      {@JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
          List<MarqueeModel> marquees,
      @required
          int speed}) {
    return _MarqueeModelList(
      marquees: marquees,
      speed: speed,
    );
  }
}

// ignore: unused_element
const $MarqueeModelList = _$MarqueeModelListTearOff();

mixin _$MarqueeModelList {
  @JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
  List<MarqueeModel> get marquees;
  int get speed;

  $MarqueeModelListCopyWith<MarqueeModelList> get copyWith;
}

abstract class $MarqueeModelListCopyWith<$Res> {
  factory $MarqueeModelListCopyWith(
          MarqueeModelList value, $Res Function(MarqueeModelList) then) =
      _$MarqueeModelListCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
          List<MarqueeModel> marquees,
      int speed});
}

class _$MarqueeModelListCopyWithImpl<$Res>
    implements $MarqueeModelListCopyWith<$Res> {
  _$MarqueeModelListCopyWithImpl(this._value, this._then);

  final MarqueeModelList _value;
  // ignore: unused_field
  final $Res Function(MarqueeModelList) _then;

  @override
  $Res call({
    Object marquees = freezed,
    Object speed = freezed,
  }) {
    return _then(_value.copyWith(
      marquees: marquees == freezed
          ? _value.marquees
          : marquees as List<MarqueeModel>,
      speed: speed == freezed ? _value.speed : speed as int,
    ));
  }
}

abstract class _$MarqueeModelListCopyWith<$Res>
    implements $MarqueeModelListCopyWith<$Res> {
  factory _$MarqueeModelListCopyWith(
          _MarqueeModelList value, $Res Function(_MarqueeModelList) then) =
      __$MarqueeModelListCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
          List<MarqueeModel> marquees,
      int speed});
}

class __$MarqueeModelListCopyWithImpl<$Res>
    extends _$MarqueeModelListCopyWithImpl<$Res>
    implements _$MarqueeModelListCopyWith<$Res> {
  __$MarqueeModelListCopyWithImpl(
      _MarqueeModelList _value, $Res Function(_MarqueeModelList) _then)
      : super(_value, (v) => _then(v as _MarqueeModelList));

  @override
  _MarqueeModelList get _value => super._value as _MarqueeModelList;

  @override
  $Res call({
    Object marquees = freezed,
    Object speed = freezed,
  }) {
    return _then(_MarqueeModelList(
      marquees: marquees == freezed
          ? _value.marquees
          : marquees as List<MarqueeModel>,
      speed: speed == freezed ? _value.speed : speed as int,
    ));
  }
}

class _$_MarqueeModelList implements _MarqueeModelList {
  const _$_MarqueeModelList(
      {@JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
          this.marquees,
      @required
          this.speed})
      : assert(speed != null);

  @override
  @JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
  final List<MarqueeModel> marquees;
  @override
  final int speed;

  @override
  String toString() {
    return 'MarqueeModelList(marquees: $marquees, speed: $speed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MarqueeModelList &&
            (identical(other.marquees, marquees) ||
                const DeepCollectionEquality()
                    .equals(other.marquees, marquees)) &&
            (identical(other.speed, speed) ||
                const DeepCollectionEquality().equals(other.speed, speed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(marquees) ^
      const DeepCollectionEquality().hash(speed);

  @override
  _$MarqueeModelListCopyWith<_MarqueeModelList> get copyWith =>
      __$MarqueeModelListCopyWithImpl<_MarqueeModelList>(this, _$identity);
}

abstract class _MarqueeModelList implements MarqueeModelList {
  const factory _MarqueeModelList(
      {@JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
          List<MarqueeModel> marquees,
      @required
          int speed}) = _$_MarqueeModelList;

  @override
  @JsonKey(name: 'marquee', fromJson: decodeMarqueeModel, required: true)
  List<MarqueeModel> get marquees;
  @override
  int get speed;
  @override
  _$MarqueeModelListCopyWith<_MarqueeModelList> get copyWith;
}
