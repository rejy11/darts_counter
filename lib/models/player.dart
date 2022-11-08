import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Player extends Equatable {
  final int id;
  final String name;
  final int remainingScore;
  final String? checkout;

  const Player(
    this.id,
    this.name,
    this.remainingScore, this.checkout,
  );

  Player copyWith({
    int? id,
    String? name,
    int? remainingScore,
    String? checkout,
  }) {
    return Player(
      id ?? this.id,
      name ?? this.name,
      remainingScore ?? this.remainingScore,
      checkout ?? this.checkout,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        remainingScore,
        checkout,
      ];
}
