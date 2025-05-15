import 'package:darts_counter/dialogs/custom_alert_dialog.dart';
import 'package:darts_counter/models/game.dart';
import 'package:darts_counter/models/player.dart';
import 'package:darts_counter/modules/x01/state/x01_state.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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

  Widget buildPlayerScoreView(
    Player player,
    bool isThrowingPlayer,
    bool invalidScore,
  ) {
    return Expanded(
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Theme.of(context).cardColor,
        ),
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    player.name,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            player.checkout != null
                ? Positioned(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Text(player.checkout.toString()),
                      ),
                    ),
                  )
                : const SizedBox(),
            isThrowingPlayer
                ? const Positioned(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 90),
                        child: Icon(Icons.arrow_right, size: 32),
                      ),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              child: Center(
                child: invalidScore && isThrowingPlayer
                    ? const Text(
                        'BUST',
                        style: TextStyle(fontSize: 32),
                      )
                    : Text(
                        player.remainingScore.toString(),
                        style: const TextStyle(fontSize: 32),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumberButton(int value) {
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            onPressed: () {
              ref.read(x01GameStateProvider.notifier).updateNewScore(value);
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: const BorderSide(width: 0, color: Colors.transparent),
            ),
            child: Text(
              value.toString(),
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(
    String actionText,
    Function()? action,
  ) {
    return Flexible(
      child: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: action,
            child: Row(
              children: [
                Text(
                  actionText,
                  style: const TextStyle(fontSize: 16),
                ),
                Icon(Icons.close)
              ],
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
              titleText: 'Restart',
              content: const Text('Are you sure?'),
              iconData: Icons.restart_alt_rounded,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("CANCEL"),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(x01GameStateProvider.notifier).restart();
                    Navigator.of(context).pop();
                  },
                  child: const Text("YES"),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.restart_alt_rounded),
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

    double rowSpacing = 6;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(game.gameSettings.startingScore.toString()),
        actions: [buildRestartButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.screenPadding),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  buildPlayerScoreView(
                    playerOne,
                    game.throwingPlayer.id == playerOne.id,
                    game.invalidScore,
                  ),
                  SizedBox(width: rowSpacing),
                  buildPlayerScoreView(
                    playerTwo,
                    game.throwingPlayer.id == playerTwo.id,
                    game.invalidScore,
                  ),
                ],
              ),
            ),
            SizedBox(height: rowSpacing),
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
                      ],
                    ),
                  ),
                  SizedBox(height: rowSpacing),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildNumberButton(7),
                        buildNumberButton(8),
                        buildNumberButton(9),
                      ],
                    ),
                  ),
                  SizedBox(height: rowSpacing),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildNumberButton(4),
                        buildNumberButton(5),
                        buildNumberButton(6),
                      ],
                    ),
                  ),
                  SizedBox(height: rowSpacing),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildNumberButton(1),
                        buildNumberButton(2),
                        buildNumberButton(3),
                      ],
                    ),
                  ),
                  SizedBox(height: rowSpacing),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildActionButton(
                          'CHECKOUT',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
