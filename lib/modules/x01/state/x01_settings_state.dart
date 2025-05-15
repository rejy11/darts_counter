import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/models/player.dart';
import 'package:darts_counter/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'x01_settings_state.g.dart';

@riverpod
class X01SettingsState extends _$X01SettingsState {
  @override
  GameSettings build() {
    final List<int> startingScores = ref.read(startingScoresProvider);
    Player playerOne = Player(
      id: 1,
      name: "Player 1",
      remainingScore: startingScores[0],
    );
    return GameSettings(
      players: [
        playerOne,
        Player(
          id: 2,
          name: "Player 2",
          remainingScore: startingScores[0],
        )
      ],
      startingScore: startingScores[0],
      startingPlayer: playerOne,
    );
  }

  void updateSettings({
    Player? player,
    int? startingScore,
    Player? startingPlayer,
  }) {
    List<Player>? players;

    if (player != null) {
      Player playerToUpdate =
          state.players.firstWhere((p) => p.id == player.id);
      players = state.players.map((p) {
        if (p.id == playerToUpdate.id) {
          return player;
        }
        return p;
      }).toList();
    }

    if (startingScore != null) {
      players = [];
      for (var player in state.players) {
        players.add(player.copyWith(remainingScore: startingScore));
      }
    }

    state = state.copyWith(
      players: players ?? state.players,
      startingScore: startingScore ?? state.startingScore,
      startingPlayer: startingPlayer ?? state.startingPlayer,
    );
  }
}
