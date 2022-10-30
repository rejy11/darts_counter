import 'package:collection/collection.dart';
import 'package:darts_counter/models/game_settings.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'player.dart';

@immutable
class Game extends Equatable {
  final GameSettings gameSettings;
  final Player playerOne;
  final Player playerTwo;
  final int newScore;
  final bool gameOver;
  final Map<int, List<int>> _previousScores; //{playerId: score}

  const Game(
    this.gameSettings,
    this.playerOne,
    this.playerTwo,
    this.newScore,
    this.gameOver,
    this._previousScores,
  );

  Map<int, List<int>> get previousScores => Map.unmodifiable(_previousScores);

  // UnmodifiableMapView<Player, int> get previousScores =>
  //     UnmodifiableMapView<Player, int>(_previousScores);

  Player get throwingPlayer {
    if (playerOne.isPlayersTurn) {
      return playerOne;
    }
    return playerTwo;
  }

  Game copyWith({
    GameSettings? gameSettings,
    Player? playerOne,
    Player? playerTwo,
    int? newScore,
    bool? gameOver,
    Map<int, List<int>>? previousScores,
  }) {
    return Game(
      gameSettings ?? this.gameSettings,
      playerOne ?? this.playerOne,
      playerTwo ?? this.playerTwo,
      newScore ?? this.newScore,
      gameOver ?? this.gameOver,
      previousScores ?? _previousScores,
    );
  }

  Game undoPreviousScore(int playerId) {
    final newPreviousScoresMap = Map<int, List<int>>.from(previousScores);
    int previousScore = 0;

    if (newPreviousScoresMap.containsKey(playerId)) {
      final playersPreviousScores = newPreviousScoresMap[playerId];
      if (playersPreviousScores!.isNotEmpty) {
        previousScore = playersPreviousScores.last;
        playersPreviousScores.removeLast();
      }
      newPreviousScoresMap[playerId] = playersPreviousScores;
    }
    if (playerId == playerOne.id) {
      return copyWith(
        previousScores: newPreviousScoresMap,
        playerOne: playerOne.copyWith(
          remainingScore: playerOne.remainingScore + previousScore,
          isPlayersTurn: true,
        ),
        playerTwo: playerTwo.copyWith(
          isPlayersTurn: false,
        ),
        gameOver: false,
        newScore: 0,
      );
    } else {
      return copyWith(
        previousScores: newPreviousScoresMap,
        playerTwo: playerTwo.copyWith(
          remainingScore: playerTwo.remainingScore + previousScore,
          isPlayersTurn: true,
        ),
        playerOne: playerOne.copyWith(
          isPlayersTurn: true,
        ),
        gameOver: false,
        newScore: 0,
      );
    }
  }

  @override
  List<Object?> get props => [
        gameSettings,
        playerOne,
        playerTwo,
        newScore,
        gameOver,
        previousScores,
      ];
}
