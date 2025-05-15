import 'package:freezed_annotation/freezed_annotation.dart';

import 'player.dart';

part 'game_settings.freezed.dart';

@freezed
class GameSettings with _$GameSettings {
  const factory GameSettings({
    required List<Player> players,
    required int startingScore,
    required Player startingPlayer,
  }) = _GameSettings;
}
