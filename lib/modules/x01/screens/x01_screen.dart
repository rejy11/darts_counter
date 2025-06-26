import 'package:darts_counter/dialogs/custom_alert_dialog.dart';
import 'package:darts_counter/extensions/iterable_extensions.dart';
import 'package:darts_counter/models/game.dart';
import 'package:darts_counter/models/player.dart';
import 'package:darts_counter/modules/x01/state/x01_state.dart';
import 'package:darts_counter/modules/x01/widgets/player_score.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:darts_counter/widgets/custom_text_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class X01Screen extends ConsumerStatefulWidget {
  const X01Screen({super.key});

  @override
  ConsumerState<X01Screen> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<X01Screen> {
  late TextEditingController _newScoreController;

  @override
  void initState() {
    _newScoreController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _newScoreController.dispose();
    super.dispose();
  }

  Widget buildNumberButton(int value) {
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            ref.read(x01GameStateProvider.notifier).updateNewScore(value);
          },
          style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(),
          ),
          child: Text(
            value.toString(),
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(
    String actionText,
    VoidCallback? action,
  ) {
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: action,
            child: Text(
              actionText,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNewScoreView() {
    return Flexible(
      child: Center(
        child: Text(
          _newScoreController.text,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildRestartButton() {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return createAlertDialog(
              titleText: 'Restart?',
              iconData: FontAwesomeIcons.rotate,
              actions: [
                CustomTextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  label: 'CANCEL',
                ),
                CustomTextButton(
                  onPressed: () {
                    ref.read(x01GameStateProvider.notifier).restart();
                    Navigator.of(context).pop();
                  },
                  label: 'YES',
                ),
              ],
            );
          },
        );
      },
      icon: const FaIcon(FontAwesomeIcons.rotate),
    );
  }

  // Evaluates whether the game has finished and shows a dialog if true
  void evaluateGameState(Game game) {
    if (game.gameOver) {
      String winningPlayer;
      if (game.players[0].remainingScore == 0) {
        winningPlayer = game.players[0].name;
      } else {
        winningPlayer = game.players[1].name;
      }
      showDialog(
        context: context,
        builder: (context) {
          return createAlertDialog(
            titleText: 'Game Shot',
            content: Text('$winningPlayer wins!'),
            iconData: Icons.celebration_rounded,
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(x01GameStateProvider.notifier).undoPreviousScore();
                  Navigator.pop(context);
                },
                child: const Text('UNDO'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(x01GameStateProvider.notifier).restart();
                  Navigator.pop(context);
                },
                child: const Text('RESTART'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Game game = ref.watch(x01GameStateProvider);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => evaluateGameState(game));

    Player playerOne = game.players[0];
    Player playerTwo = game.players[1];
    _newScoreController.text = game.newScore.toString();

    double buttonSpacing = 8;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.gameSettings.startingScore.toString()),
        actions: [buildRestartButton()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.screenPadding),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      child: PlayerScore(
                        player: playerOne,
                        isThrowingPlayer:
                            game.throwingPlayer.id == playerOne.id,
                        invalidScore: game.invalidScore,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: PlayerScore(
                        player: playerTwo,
                        isThrowingPlayer:
                            game.throwingPlayer.id == playerTwo.id,
                        invalidScore: game.invalidScore,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: buttonSpacing),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildActionButton(
                            'UNDO',
                            ref.read(x01GameStateProvider.notifier).canUndo
                                ? () => ref
                                    .read(x01GameStateProvider.notifier)
                                    .undoPreviousScore()
                                : null,
                          ),
                          buildNewScoreView(),
                          buildActionButton(
                            'CLEAR',
                            () => ref
                                .read(x01GameStateProvider.notifier)
                                .clearNewScore(),
                          ),
                        ].intersperse(SizedBox(width: buttonSpacing)).toList(),
                      ),
                    ),
                    SizedBox(height: buttonSpacing),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildNumberButton(7),
                          buildNumberButton(8),
                          buildNumberButton(9),
                        ].intersperse(SizedBox(width: buttonSpacing)).toList(),
                      ),
                    ),
                    SizedBox(height: buttonSpacing),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildNumberButton(4),
                          buildNumberButton(5),
                          buildNumberButton(6),
                        ].intersperse(SizedBox(width: buttonSpacing)).toList(),
                      ),
                    ),
                    SizedBox(height: buttonSpacing),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildNumberButton(1),
                          buildNumberButton(2),
                          buildNumberButton(3),
                        ].intersperse(SizedBox(width: buttonSpacing)).toList(),
                      ),
                    ),
                    SizedBox(height: buttonSpacing),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildActionButton(
                            'CHECK OUT',
                            ref.read(x01GameStateProvider.notifier).canCheckout
                                ? () => ref
                                    .read(x01GameStateProvider.notifier)
                                    .checkoutPlayer(game.throwingPlayer.id)
                                : null,
                          ),
                          buildNumberButton(0),
                          buildActionButton(
                            game.newScore > 0 ? 'OK' : 'NO SCORE',
                            () => ref
                                .read(x01GameStateProvider.notifier)
                                .updatePlayerScore(game.throwingPlayer.id),
                          ),
                        ].intersperse(SizedBox(width: buttonSpacing)).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
