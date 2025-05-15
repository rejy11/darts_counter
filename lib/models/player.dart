import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';

@freezed
class Player with _$Player {
  const factory Player({
    required int id,
    required String name,
    required int remainingScore,
    String? checkout,
  }) = _Player;
}
