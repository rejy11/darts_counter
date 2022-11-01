import 'package:darts_counter/extensions/list_extensions.dart';
import 'package:darts_counter/models/game.dart';
import 'package:darts_counter/models/game_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/player.dart';
import 'game_settings_state.dart';

final gameController = StateNotifierProvider<GameNotifier, Game>((ref) {
  final gameSettings = ref.watch(gameSettingsController);
  return GameNotifier(gameSettings: gameSettings);
});

class GameNotifier extends StateNotifier<Game> {
  GameNotifier({required GameSettings gameSettings})
      : super(Game(
          gameSettings,
          [gameSettings.playerOne, gameSettings.playerTwo],
          0,
          false,
          const {},
        ));

  void updatePlayerScore(int playerId, {bool checkout = false}) {
    int newRemainingScore = 0;
    final player = state.players.firstWhere((p) => p.id == playerId);

    if (checkout) {
      if (player.remainingScore > 170) {
        return;
      }
      newRemainingScore = 0;
    } else {
      newRemainingScore = player.remainingScore - state.newScore;
      if (newRemainingScore < 0 || newRemainingScore == 1) {
        return;
      }
    }
    final isGameOver = newRemainingScore == 0;

    //update previousScores map
    final newPreviousScoresMap = Map<int, List<int>>.from(state.previousScores);
    if (newPreviousScoresMap.containsKey(player.id)) {
      //if player already has a previous score registered add the new score
      final playersPreviousScores = newPreviousScoresMap[player.id];
      playersPreviousScores?.add(state.newScore);
      newPreviousScoresMap[player.id] = playersPreviousScores!;
    } else {
      //if first score add new entry
      newPreviousScoresMap[player.id] = [state.newScore];
    }

    //update players with new score
    final updatedPlayersList = state.players.toList();
    for (var i = 0; i < updatedPlayersList.length; i++) {
      if (updatedPlayersList[i].id == playerId) {
        updatedPlayersList.replaceAt(
          i,
          updatedPlayersList[i].copyWith(
            isPlayersTurn: false,
            remainingScore: newRemainingScore,
          ),
        );
      } else {
        updatedPlayersList.replaceAt(
          i,
          updatedPlayersList[i]
              .copyWith(isPlayersTurn: true),
        );
      }
    }

    //update state
    state = state.copyWith(
      newScore: 0,
      gameOver: isGameOver,
      previousScores: newPreviousScoresMap,
      players: updatedPlayersList,
    );
  }

  void updateNewScore(int score) {
    if (state.newScore + score > 180) return;

    final newScoreString = state.newScore.toString() + score.toString();
    final newScore = int.tryParse(newScoreString);

    if (newScore! > 180) return;

    state = state.copyWith(newScore: newScore);
  }

  void clearNewScore() {
    state = state.copyWith(newScore: 0);
  }

  void undoPreviousScore() {
    if (state.previousScores.isNotEmpty) {
      final player =
          state.players.firstWhere((element) => !element.isPlayersTurn);

      if(state.previousScores[player.id]!.isEmpty){
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
                isPlayersTurn: true,
                remainingScore: player.remainingScore + previousScore,
              ),
            );
          } else {
            updatedPlayersList.replaceAt(
              i,
              updatedPlayersList[i].copyWith(isPlayersTurn: false),
            );
          }
        }

        state = state.copyWith(
          players: updatedPlayersList,
          previousScores: updatedPreviousScoresMap,
          gameOver: false,
          newScore: 0,
        );
      }
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
    );
  }
}
