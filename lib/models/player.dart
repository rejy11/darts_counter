import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Player extends Equatable {
  final int id;
  final String name;
  final int remainingScore;
  final bool isPlayersTurn;

  const Player(
    this.id,
    this.name,
    this.remainingScore,
    this.isPlayersTurn,
  );

  Player copyWith({
    int? id,
    String? name,
    int? remainingScore,
    bool? isPlayersTurn,
  }) {
    return Player(
      id ?? this.id,
      name ?? this.name,
      remainingScore ?? this.remainingScore,
      isPlayersTurn ?? this.isPlayersTurn,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        remainingScore,
        isPlayersTurn,
      ];
}
