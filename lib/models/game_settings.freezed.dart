// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameSettings {
  List<Player> get players => throw _privateConstructorUsedError;
  int get startingScore => throw _privateConstructorUsedError;
  Player get startingPlayer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameSettingsCopyWith<GameSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSettingsCopyWith<$Res> {
  factory $GameSettingsCopyWith(
          GameSettings value, $Res Function(GameSettings) then) =
      _$GameSettingsCopyWithImpl<$Res, GameSettings>;
  @useResult
  $Res call({List<Player> players, int startingScore, Player startingPlayer});

  $PlayerCopyWith<$Res> get startingPlayer;
}

/// @nodoc
class _$GameSettingsCopyWithImpl<$Res, $Val extends GameSettings>
    implements $GameSettingsCopyWith<$Res> {
  _$GameSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
    Object? startingScore = null,
    Object? startingPlayer = null,
  }) {
    return _then(_value.copyWith(
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      startingScore: null == startingScore
          ? _value.startingScore
          : startingScore // ignore: cast_nullable_to_non_nullable
              as int,
      startingPlayer: null == startingPlayer
          ? _value.startingPlayer
          : startingPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get startingPlayer {
    return $PlayerCopyWith<$Res>(_value.startingPlayer, (value) {
      return _then(_value.copyWith(startingPlayer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameSettingsImplCopyWith<$Res>
    implements $GameSettingsCopyWith<$Res> {
  factory _$$GameSettingsImplCopyWith(
          _$GameSettingsImpl value, $Res Function(_$GameSettingsImpl) then) =
      __$$GameSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Player> players, int startingScore, Player startingPlayer});

  @override
  $PlayerCopyWith<$Res> get startingPlayer;
}

/// @nodoc
class __$$GameSettingsImplCopyWithImpl<$Res>
    extends _$GameSettingsCopyWithImpl<$Res, _$GameSettingsImpl>
    implements _$$GameSettingsImplCopyWith<$Res> {
  __$$GameSettingsImplCopyWithImpl(
      _$GameSettingsImpl _value, $Res Function(_$GameSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
    Object? startingScore = null,
    Object? startingPlayer = null,
  }) {
    return _then(_$GameSettingsImpl(
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      startingScore: null == startingScore
          ? _value.startingScore
          : startingScore // ignore: cast_nullable_to_non_nullable
              as int,
      startingPlayer: null == startingPlayer
          ? _value.startingPlayer
          : startingPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
    ));
  }
}

/// @nodoc

class _$GameSettingsImpl implements _GameSettings {
  const _$GameSettingsImpl(
      {required final List<Player> players,
      required this.startingScore,
      required this.startingPlayer})
      : _players = players;

  final List<Player> _players;
  @override
  List<Player> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  final int startingScore;
  @override
  final Player startingPlayer;

  @override
  String toString() {
    return 'GameSettings(players: $players, startingScore: $startingScore, startingPlayer: $startingPlayer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSettingsImpl &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.startingScore, startingScore) ||
                other.startingScore == startingScore) &&
            (identical(other.startingPlayer, startingPlayer) ||
                other.startingPlayer == startingPlayer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_players),
      startingScore,
      startingPlayer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameSettingsImplCopyWith<_$GameSettingsImpl> get copyWith =>
      __$$GameSettingsImplCopyWithImpl<_$GameSettingsImpl>(this, _$identity);
}

abstract class _GameSettings implements GameSettings {
  const factory _GameSettings(
      {required final List<Player> players,
      required final int startingScore,
      required final Player startingPlayer}) = _$GameSettingsImpl;

  @override
  List<Player> get players;
  @override
  int get startingScore;
  @override
  Player get startingPlayer;
  @override
  @JsonKey(ignore: true)
  _$$GameSettingsImplCopyWith<_$GameSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
