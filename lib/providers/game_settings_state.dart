import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/models/player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameSettingsController =
    StateNotifierProvider<GameSettingsNotifier, GameSettings>(
  (ref) {
    const startingScore = 301;
    const playerOne = Player(1, "Player 1", startingScore, null);
    const playerTwo = Player(2, "Player 2", startingScore, null);
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

  void updateSettings({
    String? playerOneName,
    String? playerTwoName,
    int? startingScore,
  }) {
    state = state.copyWith(
      playerOne: playerOneName == null ? state.playerOne : state.playerOne.copyWith(name: playerOneName),
      playerTwo: playerTwoName == null ? state.playerTwo : state.playerTwo.copyWith(name: playerTwoName),
      startingScore: startingScore ?? state.startingScore,
    );
  }

  void updatePlayersTurn(int playerId) {
    if (state.playerOne.id == playerId) {
      state = state.copyWith(startingPlayer: state.playerOne);
    } else {
      state = state.copyWith(startingPlayer: state.playerTwo);
    }
  }
}
