// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Player {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get remainingScore => throw _privateConstructorUsedError;
  String? get checkout => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call({int id, String name, int remainingScore, String? checkout});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? remainingScore = null,
    Object? checkout = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      remainingScore: null == remainingScore
          ? _value.remainingScore
          : remainingScore // ignore: cast_nullable_to_non_nullable
              as int,
      checkout: freezed == checkout
          ? _value.checkout
          : checkout // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, int remainingScore, String? checkout});
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? remainingScore = null,
    Object? checkout = freezed,
  }) {
    return _then(_$PlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      remainingScore: null == remainingScore
          ? _value.remainingScore
          : remainingScore // ignore: cast_nullable_to_non_nullable
              as int,
      checkout: freezed == checkout
          ? _value.checkout
          : checkout // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PlayerImpl implements _Player {
  const _$PlayerImpl(
      {required this.id,
      required this.name,
      required this.remainingScore,
      this.checkout});

  @override
  final int id;
  @override
  final String name;
  @override
  final int remainingScore;
  @override
  final String? checkout;

  @override
  String toString() {
    return 'Player(id: $id, name: $name, remainingScore: $remainingScore, checkout: $checkout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.remainingScore, remainingScore) ||
                other.remainingScore == remainingScore) &&
            (identical(other.checkout, checkout) ||
                other.checkout == checkout));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, remainingScore, checkout);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);
}

abstract class _Player implements Player {
  const factory _Player(
      {required final int id,
      required final String name,
      required final int remainingScore,
      final String? checkout}) = _$PlayerImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  int get remainingScore;
  @override
  String? get checkout;
  @override
  @JsonKey(ignore: true)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
