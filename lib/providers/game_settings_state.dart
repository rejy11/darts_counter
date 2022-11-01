import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/models/player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameSettingsController =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>(
  (ref) {
    const startingScore = 301;
    const playerOne = Player(1, "Player 1", startingScore);
    const playerTwo = Player(2, "Player 2", startingScore);
    const settings = GameSettings(
      playerOne,
      playerTwo,
      startingScore,
      playerOne,
    );
    return GameSettingsNotifier(settings);
  },
);

class GameSettingsNotifier extends StateNotifier<GameSettings> {
  GameSettingsNotifier(GameSettings settings) : super(settings);

  void updatePlayerOneName(String name) {
    state = state.copyWith(playerOne: state.playerOne.copyWith(name: name));
  }

  void updatePlayerTwoName(String name) {
    state = state.copyWith(playerTwo: state.playerTwo.copyWith(name: name));
  }

  void updatePlayersTurn(int playerId) {
    if (state.playerOne.id == playerId) {
      state = state.copyWith(startingPlayer: state.playerOne);
    } else {
      state = state.copyWith(startingPlayer: state.playerTwo);
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
