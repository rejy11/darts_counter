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
          gameSettings.playerOne,
          gameSettings.playerTwo,
          0,
          false,
          {},
        ));

  void updatePlayerOneScore() {
    final newRemainingScore = state.playerOne.remainingScore - state.newScore;
    if (newRemainingScore < 0 || newRemainingScore == 1) {
      return;
    }
    final isGameOver = newRemainingScore == 0;

    final newPreviousScoresMap = Map<int, List<int>>.from(state.previousScores);
    if (newPreviousScoresMap.containsKey(state.playerOne.id)) {
      final playersPreviousScores = newPreviousScoresMap[state.playerOne.id];
      playersPreviousScores?.add(state.newScore);
      newPreviousScoresMap[state.playerOne.id] = playersPreviousScores!;
    }else{
      newPreviousScoresMap[state.playerOne.id] = [state.newScore];
    }

    state = state.copyWith(
      playerOne: state.playerOne.copyWith(
        remainingScore: newRemainingScore,
        isPlayersTurn: false,
      ),
      playerTwo: state.playerTwo.copyWith(
        isPlayersTurn: true,
      ),
      newScore: 0,
      gameOver: isGameOver,
      previousScores: newPreviousScoresMap,
    );
  }

  void updatePlayerTwoScore() {
    final newRemainingScore = state.playerTwo.remainingScore - state.newScore;
    if (newRemainingScore < 0 || newRemainingScore == 1) {
      return;
    }
    final isGameOver = newRemainingScore == 0;

    final newPreviousScoresMap = Map<int, List<int>>.from(state.previousScores);
    if (newPreviousScoresMap.containsKey(state.playerTwo.id)) {
      final playersPreviousScores = newPreviousScoresMap[state.playerTwo.id];
      playersPreviousScores?.add(state.newScore);
      newPreviousScoresMap[state.playerTwo.id] = playersPreviousScores!;
    }
    else{
      newPreviousScoresMap[state.playerTwo.id] = [state.newScore];
    }

    state = state.copyWith(
      playerTwo: state.playerTwo.copyWith(
        remainingScore: newRemainingScore,
        isPlayersTurn: false,
      ),
      playerOne: state.playerOne.copyWith(
        isPlayersTurn: true,
      ),
      newScore: 0,
      gameOver: isGameOver,
      previousScores: newPreviousScoresMap,
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
    if (state.throwingPlayer == state.playerOne) {
      if (!state.previousScores.containsKey(state.playerTwo.id)) {
        return;
      }
      //undo player 2 previous shot
      state = state.undoPreviousScore(state.playerTwo.id);
    } else {
      if (!state.previousScores.containsKey(state.playerOne.id)) {
        return;
      }
      //undo player 1 previous shot
      state = state.undoPreviousScore(state.playerOne.id);
    }
  }

  void checkoutCurrentPlayer() {
    if (state.throwingPlayer == state.playerOne) {
      if (state.playerOne.remainingScore > 50) {
        //TODO: use service to validate
        return;
      }

      final newPreviousScores = state.previousScores[state.playerOne.id];
      newPreviousScores!.add(state.playerOne.remainingScore);

      state = state.copyWith(
        playerOne: state.playerOne.copyWith(
          remainingScore: 0,
        ),
        gameOver: true,
        previousScores: {
          ...state.previousScores,
          ...{state.playerOne.id: newPreviousScores}
        },
      );
    } else {
      if (state.playerTwo.remainingScore > 50) {
        return;
      }

      final newPreviousScores = state.previousScores[state.playerTwo.id];
      newPreviousScores!.add(state.playerTwo.remainingScore);

      state = state.copyWith(
        playerTwo: state.playerTwo.copyWith(
          remainingScore: 0,
        ),
        gameOver: true,
        previousScores: {
          ...state.previousScores,
          ...{state.playerTwo.id: newPreviousScores}
        },
      );
    }
  }

  void restart() {
    state = state.copyWith(
        playerOne: state.playerOne.copyWith(
          remainingScore: state.gameSettings.startingScore,
        ),
        playerTwo: state.playerTwo.copyWith(
          remainingScore: state.gameSettings.startingScore,
        ),
        gameOver: false,
        newScore: 0,
        previousScores: {});
  }
}
