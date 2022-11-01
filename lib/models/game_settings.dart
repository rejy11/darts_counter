import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'player.dart';

@immutable
class GameSettings extends Equatable {
  final Player playerOne;
  final Player playerTwo;
  final int startingScore;
  final Player startingPlayer;

  const GameSettings(
    this.playerOne,
    this.playerTwo,
    this.startingScore,
    this.startingPlayer,
  );

  GameSettings copyWith({
    Player? playerOne,
    Player? playerTwo,
    int? startingScore,
    Player? startingPlayer,
  }) {
    return GameSettings(
      playerOne ?? this.playerOne,
      playerTwo ?? this.playerTwo,
      startingScore ?? this.startingScore,
      startingPlayer ?? this.startingPlayer,
    );
  }

  @override
  List<Object?> get props => [
        playerOne,
        playerTwo,
        startingScore,
        startingPlayer,
      ];
}
