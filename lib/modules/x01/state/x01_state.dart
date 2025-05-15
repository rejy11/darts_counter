import 'package:darts_counter/extensions/list_extensions.dart';
import 'package:darts_counter/models/game.dart';
import 'package:darts_counter/models/player.dart';
import 'package:darts_counter/modules/x01/state/x01_settings_state.dart';
import 'package:darts_counter/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'x01_state.g.dart';

@riverpod
class X01GameState extends _$X01GameState {
  @override
  Game build() {
    final gameSettings = ref.watch(x01SettingsStateProvider);
    _checkoutMap = ref.read(checkoutProvider);
    return Game(
      gameSettings: gameSettings,
      players: gameSettings.players,
      newScore: 0,
      gameOver: false,
      previousScores: const {},
      throwingPlayer: gameSettings.startingPlayer,
      invalidScore: false,
    );
  }

  late Map<int, String> _checkoutMap;

  void updatePlayerScore(int playerId, {bool checkout = false}) {
    int scoreToDeduct = state.newScore;
    int newRemainingScore = 0;
    final player = state.players.firstWhere((p) => p.id == playerId);

    if (checkout) {
      // Check if valid checkout
      if (!_checkoutMap.containsKey(player.remainingScore)) {
        return;
      }
      // Valid checkout so set remaining score to 0 and score to deduct
      // will be the players remaining score
      newRemainingScore = 0;
      scoreToDeduct = player.remainingScore;
    } else {
      // Calculate remaining score
      newRemainingScore = player.remainingScore - scoreToDeduct;
      // If an invalid score has been thrown, reset the remaining score
      // and score to deduct
      if (newRemainingScore < 0 || newRemainingScore == 1) {
        newRemainingScore += scoreToDeduct;
        scoreToDeduct = 0;
      }
    }

    // Update previous scores map
    final newPreviousScoresMap = Map<int, List<int>>.from(state.previousScores);
    if (newPreviousScoresMap.containsKey(player.id)) {
      // If player already has a previous score registered add the new score
      final List<int> playersPreviousScores = newPreviousScoresMap[player.id]!;
      playersPreviousScores.add(scoreToDeduct);
      newPreviousScoresMap[player.id] = playersPreviousScores;
    } else {
      // If first score add new entry
      newPreviousScoresMap[player.id] = [scoreToDeduct];
    }
    // Update players with new score
    final List<Player> updatedPlayersList = state.players.toList();
    for (var i = 0; i < updatedPlayersList.length; i++) {
      if (updatedPlayersList[i].id == playerId) {
        updatedPlayersList.replaceAt(
          i,
          updatedPlayersList[i].copyWith(
            remainingScore: newRemainingScore,
            checkout: _getCheckout(newRemainingScore),
          ),
        );
      }
    }
    // Get new throwing player
    final newThrowingPlayer = updatedPlayersList
        .firstWhere((player) => player.id != state.throwingPlayer.id);

    state = state.copyWith(
      newScore: 0,
      gameOver: newRemainingScore == 0,
      previousScores: newPreviousScoresMap,
      players: updatedPlayersList,
      throwingPlayer: newThrowingPlayer,
      invalidScore: false,
    );
  }

  /// Takes an integer, parsing the newly entered score and evaluating
  /// if it's a valid score and updates the state.
  void updateNewScore(int score) {
    if (state.newScore + score > 180) return;
    bool invalidScore = false;

    // Convert to String e.g. '6' + '0' = '60'
    final newScoreString = state.newScore.toString() + score.toString();
    // Parse '60' to int
    final newScore = int.tryParse(newScoreString);

    if (newScore! > 180) return;

    // Player has scored too much
    if (state.throwingPlayer.remainingScore - newScore < 0) {
      invalidScore = true;
    }

    state = state.copyWith(
      newScore: newScore,
      invalidScore: invalidScore,
    );
  }

  void clearNewScore() {
    state = state.copyWith(newScore: 0, invalidScore: false);
  }

  void undoPreviousScore() {
    final player = state.players
        .firstWhere((player) => player.id != state.throwingPlayer.id);

    if (!state.previousScores.containsKey(player.id) ||
        state.previousScores[player.id]!.isEmpty) {
      return;
    }

    final updatedPreviousScoresMap =
        Map<int, List<int>>.from(state.previousScores);
    int previousScore = 0;

    // Get the player's previous scores and remove the last score
    // and create new map with updated previous scores
    final playersPreviousScores = updatedPreviousScoresMap[player.id];
    previousScore = playersPreviousScores!.last;
    playersPreviousScores.removeLast();
    updatedPreviousScoresMap[player.id] = playersPreviousScores;

    // Update players list with new score
    final updatedPlayersList = state.players.toList();
    for (var i = 0; i < updatedPlayersList.length; i++) {
      if (updatedPlayersList[i].id == player.id) {
        final int newScore = player.remainingScore + previousScore;
        updatedPlayersList.replaceAt(
          i,
          updatedPlayersList[i].copyWith(
            remainingScore: newScore,
            checkout: _getCheckout(newScore),
          ),
        );
      }
    }

    //get new throwing player
    final newThrowingPlayer = updatedPlayersList
        .firstWhere((element) => element.id != state.throwingPlayer.id);

    state = state.copyWith(
      players: updatedPlayersList,
      previousScores: updatedPreviousScoresMap,
      gameOver: false,
      newScore: 0,
      throwingPlayer: newThrowingPlayer,
      invalidScore: false,
    );
  }

  void checkoutPlayer(int playerId) {
    updatePlayerScore(playerId, checkout: true);
  }

  void restart() {
    state = state.copyWith(
      players: state.gameSettings.players,
      gameOver: false,
      newScore: 0,
      previousScores: {},
      invalidScore: false,
    );
  }

  bool get canCheckout =>
      _checkoutMap.containsKey(state.throwingPlayer.remainingScore);

  String? _getCheckout(int remainingScore) => _checkoutMap[remainingScore];

  bool get canUndo => state.previousScores.containsKey(state.throwingPlayer.id);
}
