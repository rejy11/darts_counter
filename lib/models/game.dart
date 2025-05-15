import 'package:darts_counter/models/game_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'player.dart';

part 'game.freezed.dart';

@freezed
class Game with _$Game {
  const factory Game({
    required GameSettings gameSettings,
    required List<Player> players,
    required int newScore,
    required bool gameOver,
    required Map<int, List<int>> previousScores,
    required Player throwingPlayer,
    required bool invalidScore,
  }) = _Game;
}
