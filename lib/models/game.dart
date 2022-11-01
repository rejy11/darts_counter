import 'package:collection/collection.dart';
import 'package:darts_counter/models/game_settings.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'player.dart';

@immutable
class Game extends Equatable {
  final GameSettings gameSettings;
  final int newScore;
  final bool gameOver;
  final Map<int, List<int>> _previousScores; //{playerId: score}
  final List<Player> _players;

  const Game(
    this.gameSettings,
    this._players,
    this.newScore,
    this.gameOver,
    this._previousScores,
  );

  UnmodifiableListView<Player> get players =>
      UnmodifiableListView<Player>(_players);

  UnmodifiableMapView<int, List<int>> get previousScores =>
      UnmodifiableMapView<int, List<int>>(_previousScores);

  Player get throwingPlayer {
    return players.firstWhere((element) => element.isPlayersTurn);
  }

  Game copyWith({
    GameSettings? gameSettings,
    List<Player>? players,
    int? newScore,
    bool? gameOver,
    Map<int, List<int>>? previousScores,
  }) {
    return Game(
      gameSettings ?? this.gameSettings,
      players ?? this.players,
      newScore ?? this.newScore,
      gameOver ?? this.gameOver,
      previousScores ?? _previousScores,
    );
  }

  @override
  List<Object?> get props => [
        gameSettings,
        players,
        newScore,
        gameOver,
        previousScores,
      ];
}
