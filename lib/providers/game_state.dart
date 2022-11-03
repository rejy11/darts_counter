import 'package:darts_counter/extensions/list_extensions.dart';
import 'package:darts_counter/models/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_settings_state.dart';

final gameController = StateNotifierProvider<GameNotifier, Game>((ref) {
  final gameSettings = ref.watch(gameSettingsController);
  final game = Game(
    gameSettings,
    [gameSettings.playerOne, gameSettings.playerTwo],
    0,
    false,
    const {},
    gameSettings.startingPlayer,
    false,
  );
  return GameNotifier(game);
});

class GameNotifier extends StateNotifier<Game> {
  GameNotifier(Game game) : super(game);

  void updatePlayerScore(int playerId, {bool checkout = false}) {
    int scoreToDeduct = state.newScore;
    int newPlayerRemainingScore = 0;
    final player = state.players.firstWhere((p) => p.id == playerId);

    if (checkout) {
      if (player.remainingScore > 170) {
        return;
      }
      newPlayerRemainingScore = 0;
      scoreToDeduct = player.remainingScore;
    } else {
      newPlayerRemainingScore = player.remainingScore - scoreToDeduct;
      if (newPlayerRemainingScore < 0 || newPlayerRemainingScore == 1) {
        newPlayerRemainingScore += scoreToDeduct;
        scoreToDeduct = 0;
      }
    }
    final isGameOver = newPlayerRemainingScore == 0;

    //update previousScores map
    final newPreviousScoresMap = Map<int, List<int>>.from(state.previousScores);
    if (newPreviousScoresMap.containsKey(player.id)) {
      //if player already has a previous score registered add the new score
      final playersPreviousScores = newPreviousScoresMap[player.id];
      playersPreviousScores?.add(scoreToDeduct);
      newPreviousScoresMap[player.id] = playersPreviousScores!;
    } else {
      //if first score add new entry
      newPreviousScoresMap[player.id] = [scoreToDeduct];
    }

    //update players with new score
    final updatedPlayersList = state.players.toList();
    for (var i = 0; i < updatedPlayersList.length; i++) {
      if (updatedPlayersList[i].id == playerId) {
        updatedPlayersList.replaceAt(
          i,
          updatedPlayersList[i].copyWith(
            remainingScore: newPlayerRemainingScore,
          ),
        );
      }
    }

    //get new throwing player
    final newThrowingPlayer = updatedPlayersList
        .firstWhere((element) => element.id != state.throwingPlayer.id);

    //update state
    state = state.copyWith(
      newScore: 0,
      gameOver: isGameOver,
      previousScores: newPreviousScoresMap,
      players: updatedPlayersList,
      throwingPlayer: newThrowingPlayer,
      invalidScore: false,
    );
  }

  void updateNewScore(int score) {
    if (state.newScore + score > 180) return;
    bool invalidScore = false;

    final newScoreString = state.newScore.toString() + score.toString();
    final newScore = int.tryParse(newScoreString);

    if (newScore! > 180) return;

    if (state.throwingPlayer.remainingScore - newScore < 0) {
      invalidScore = true;
    }

    state = state.copyWith(
      newScore: newScore,
      invalidScore: invalidScore,
    );
  }

  void clearNewScore() {
    state = state.copyWith(newScore: 0, invalidScore: false);
  }

  void undoPreviousScore() {
    if (state.previousScores.isEmpty) {
      return;
    }
    final player = state.players
        .firstWhere((element) => element.id != state.throwingPlayer.id);

    if (state.previousScores[player.id]!.isEmpty) {
      return;
    }

    final updatedPreviousScoresMap =
        Map<int, List<int>>.from(state.previousScores);
    int previousScore = 0;

    if (updatedPreviousScoresMap.containsKey(player.id)) {
      final playersPreviousScores = updatedPreviousScoresMap[player.id];
      if (playersPreviousScores!.isNotEmpty) {
        previousScore = playersPreviousScores.last;
        playersPreviousScores.removeLast();
      }
      updatedPreviousScoresMap[player.id] = playersPreviousScores;

      //update players with new score
      final updatedPlayersList = state.players.toList();
      for (var i = 0; i < updatedPlayersList.length; i++) {
        if (updatedPlayersList[i].id == player.id) {
          updatedPlayersList.replaceAt(
            i,
            updatedPlayersList[i].copyWith(
              remainingScore: player.remainingScore + previousScore,
            ),
          );
        }
      }

      //get new throwing player
      final newThrowingPlayer = updatedPlayersList
          .firstWhere((element) => element.id != state.throwingPlayer.id);

      state = state.copyWith(
        players: updatedPlayersList,
        previousScores: updatedPreviousScoresMap,
        gameOver: false,
        newScore: 0,
        throwingPlayer: newThrowingPlayer,
        invalidScore: false,
      );
    }
  }

  void checkoutPlayer(int playerId) {
    updatePlayerScore(playerId, checkout: true);
  }

  void restart() {
    state = state.copyWith(
      players: [
        state.gameSettings.playerOne,
        state.gameSettings.playerTwo,
      ],
      gameOver: false,
      newScore: 0,
      previousScores: {},
      invalidScore: false,
    );
  }
}
