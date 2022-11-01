import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Player extends Equatable {
  final int id;
  final String name;
  final int remainingScore;

  const Player(
    this.id,
    this.name,
    this.remainingScore,
  );

  Player copyWith({
    int? id,
    String? name,
    int? remainingScore,
  }) {
    return Player(
      id ?? this.id,
      name ?? this.name,
      remainingScore ?? this.remainingScore,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        remainingScore,
      ];
}
