import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/models/player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameSettingsController =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>((ref) {
  return GameSettingsNotifier();
});

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier()
      : super(
          const GameSettings(
            Player(1, "Player 1", 301, true),
            Player(2, "Player 2", 301, false),
            301,
          ),
        );

  void updatePlayerOneName(String name) {
    state = state.copyWith(playerOne: state.playerOne.copyWith(name: name));
  }

  void updatePlayerTwoName(String name) {
    state = state.copyWith(
      playerTwo: state.playerTwo.copyWith(name: name),
    );
  }

  void updatePlayersTurn(int playerId) {
    if (state.playerOne.id == playerId) {
      state = state.copyWith(
        playerOne: state.playerOne.copyWith(isPlayersTurn: true),
        playerTwo: state.playerTwo.copyWith(isPlayersTurn: false),
      );
    } else {
      state = state.copyWith(
        playerOne: state.playerOne.copyWith(isPlayersTurn: false),
        playerTwo: state.playerTwo.copyWith(isPlayersTurn: true),
      );
    }
  }

  void updateStartingScore(int startingScore) {
    state = state.copyWith(
      playerOne: state.playerOne.copyWith(remainingScore: startingScore),
      playerTwo: state.playerTwo.copyWith(remainingScore: startingScore),
      startingScore: startingScore,
    );
  }
}
