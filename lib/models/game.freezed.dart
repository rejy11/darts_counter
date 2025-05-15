// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Game {
  GameSettings get gameSettings => throw _privateConstructorUsedError;
  List<Player> get players => throw _privateConstructorUsedError;
  int get newScore => throw _privateConstructorUsedError;
  bool get gameOver => throw _privateConstructorUsedError;
  Map<int, List<int>> get previousScores => throw _privateConstructorUsedError;
  Player get throwingPlayer => throw _privateConstructorUsedError;
  bool get invalidScore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {GameSettings gameSettings,
      List<Player> players,
      int newScore,
      bool gameOver,
      Map<int, List<int>> previousScores,
      Player throwingPlayer,
      bool invalidScore});

  $GameSettingsCopyWith<$Res> get gameSettings;
  $PlayerCopyWith<$Res> get throwingPlayer;
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameSettings = null,
    Object? players = null,
    Object? newScore = null,
    Object? gameOver = null,
    Object? previousScores = null,
    Object? throwingPlayer = null,
    Object? invalidScore = null,
  }) {
    return _then(_value.copyWith(
      gameSettings: null == gameSettings
          ? _value.gameSettings
          : gameSettings // ignore: cast_nullable_to_non_nullable
              as GameSettings,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      newScore: null == newScore
          ? _value.newScore
          : newScore // ignore: cast_nullable_to_non_nullable
              as int,
      gameOver: null == gameOver
          ? _value.gameOver
          : gameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      previousScores: null == previousScores
          ? _value.previousScores
          : previousScores // ignore: cast_nullable_to_non_nullable
              as Map<int, List<int>>,
      throwingPlayer: null == throwingPlayer
          ? _value.throwingPlayer
          : throwingPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      invalidScore: null == invalidScore
          ? _value.invalidScore
          : invalidScore // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameSettingsCopyWith<$Res> get gameSettings {
    return $GameSettingsCopyWith<$Res>(_value.gameSettings, (value) {
      return _then(_value.copyWith(gameSettings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerCopyWith<$Res> get throwingPlayer {
    return $PlayerCopyWith<$Res>(_value.throwingPlayer, (value) {
      return _then(_value.copyWith(throwingPlayer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameSettings gameSettings,
      List<Player> players,
      int newScore,
      bool gameOver,
      Map<int, List<int>> previousScores,
      Player throwingPlayer,
      bool invalidScore});

  @override
  $GameSettingsCopyWith<$Res> get gameSettings;
  @override
  $PlayerCopyWith<$Res> get throwingPlayer;
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameSettings = null,
    Object? players = null,
    Object? newScore = null,
    Object? gameOver = null,
    Object? previousScores = null,
    Object? throwingPlayer = null,
    Object? invalidScore = null,
  }) {
    return _then(_$GameImpl(
      gameSettings: null == gameSettings
          ? _value.gameSettings
          : gameSettings // ignore: cast_nullable_to_non_nullable
              as GameSettings,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      newScore: null == newScore
          ? _value.newScore
          : newScore // ignore: cast_nullable_to_non_nullable
              as int,
      gameOver: null == gameOver
          ? _value.gameOver
          : gameOver // ignore: cast_nullable_to_non_nullable
              as bool,
      previousScores: null == previousScores
          ? _value._previousScores
          : previousScores // ignore: cast_nullable_to_non_nullable
              as Map<int, List<int>>,
      throwingPlayer: null == throwingPlayer
          ? _value.throwingPlayer
          : throwingPlayer // ignore: cast_nullable_to_non_nullable
              as Player,
      invalidScore: null == invalidScore
          ? _value.invalidScore
          : invalidScore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GameImpl implements _Game {
  const _$GameImpl(
      {required this.gameSettings,
      required final List<Player> players,
      required this.newScore,
      required this.gameOver,
      required final Map<int, List<int>> previousScores,
      required this.throwingPlayer,
      required this.invalidScore})
      : _players = players,
        _previousScores = previousScores;

  @override
  final GameSettings gameSettings;
  final List<Player> _players;
  @override
  List<Player> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  final int newScore;
  @override
  final bool gameOver;
  final Map<int, List<int>> _previousScores;
  @override
  Map<int, List<int>> get previousScores {
    if (_previousScores is EqualUnmodifiableMapView) return _previousScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_previousScores);
  }

  @override
  final Player throwingPlayer;
  @override
  final bool invalidScore;

  @override
  String toString() {
    return 'Game(gameSettings: $gameSettings, players: $players, newScore: $newScore, gameOver: $gameOver, previousScores: $previousScores, throwingPlayer: $throwingPlayer, invalidScore: $invalidScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.gameSettings, gameSettings) ||
                other.gameSettings == gameSettings) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.newScore, newScore) ||
                other.newScore == newScore) &&
            (identical(other.gameOver, gameOver) ||
                other.gameOver == gameOver) &&
            const DeepCollectionEquality()
                .equals(other._previousScores, _previousScores) &&
            (identical(other.throwingPlayer, throwingPlayer) ||
                other.throwingPlayer == throwingPlayer) &&
            (identical(other.invalidScore, invalidScore) ||
                other.invalidScore == invalidScore));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      gameSettings,
      const DeepCollectionEquality().hash(_players),
      newScore,
      gameOver,
      const DeepCollectionEquality().hash(_previousScores),
      throwingPlayer,
      invalidScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);
}

abstract class _Game implements Game {
  const factory _Game(
      {required final GameSettings gameSettings,
      required final List<Player> players,
      required final int newScore,
      required final bool gameOver,
      required final Map<int, List<int>> previousScores,
      required final Player throwingPlayer,
      required final bool invalidScore}) = _$GameImpl;

  @override
  GameSettings get gameSettings;
  @override
  List<Player> get players;
  @override
  int get newScore;
  @override
  bool get gameOver;
  @override
  Map<int, List<int>> get previousScores;
  @override
  Player get throwingPlayer;
  @override
  bool get invalidScore;
  @override
  @JsonKey(ignore: true)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
