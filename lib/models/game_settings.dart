import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'player.dart';

@immutable
class GameSettings extends Equatable {
  final Player playerOne;
  final Player playerTwo;
  final int startingScore;

  const GameSettings(
    this.playerOne,
    this.playerTwo,
    this.startingScore,
  );

  GameSettings copyWith({
    Player? playerOne,
    Player? playerTwo,
    int? startingScore,
  }) {
    return GameSettings(
      playerOne ?? this.playerOne,
      playerTwo ?? this.playerTwo,
      startingScore ?? this.startingScore,
    );
  }

  @override
  List<Object?> get props => [
        playerOne,
        playerTwo,
        startingScore,
      ];
}
