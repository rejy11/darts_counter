import 'package:community_material_icon/community_material_icon.dart';
import 'package:darts_counter/dialogs/custom_alert_dialog.dart';
import 'package:darts_counter/models/game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../models/player.dart';
import '../providers/game_state.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
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
      Player player, bool isThrowingPlayer, bool invalidScore) {
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(
          width: double.infinity,
          height: double.infinity,
        ),
        child: Container(
          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(player.name),
                ),
              ),
              isThrowingPlayer
                  ? const Positioned(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 80),
                          child: Icon(Icons.arrow_right, size: 32),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                child: Center(
                  child: invalidScore && isThrowingPlayer
                      ? const Text('BUST')
                      : Text(
                          player.remainingScore.toString(),
                          style: const TextStyle(fontSize: 32),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberButton(int value) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: TextButton(
          onPressed: () {
            ref.read(gameController.notifier).updateNewScore(value);
          },
          child: Text(
            value.toString(),
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(String actionText, Function()? action) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: TextButton(
          onPressed: action,
          child: Text(
            actionText,
          ),
        ),
      ),
    );
  }

  Widget buildNewScoreView() {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          controller: _newScoreController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          readOnly: true,
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
              bodyText: 'Are you sure?',
              iconData: Icons.restart_alt_rounded,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(gameController.notifier).restart();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes"),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.restart_alt_rounded),
    );
  }

  //Evaluates whether the game has finished (a player has reached 0) and shows a dialog if true
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
            bodyText: '$winningPlayer wins!',
            iconData: CommunityMaterialIcons.bullseye_arrow,
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(gameController.notifier).undoPreviousScore();
                  Navigator.pop(context);
                },
                child: const Text('Undo'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(gameController.notifier).restart();
                  Navigator.pop(context);
                },
                child: const Text('Restart'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Game game = ref.watch(gameController);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => evaluateGameState(game));

    Player playerOne = game.players[0];
    Player playerTwo = game.players[1];
    _newScoreController.text = game.newScore.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text('Game on'),
        actions: [
          buildRestartButton(),
        ],
      ),
      body: Column(
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
                buildPlayerScoreView(
                  playerTwo,
                  game.throwingPlayer.id == playerTwo.id,
                  game.invalidScore,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: double.infinity,
                height: double.infinity,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildActionButton(
                            'UNDO',
                            () => ref
                                .read(gameController.notifier)
                                .undoPreviousScore()),
                        buildNewScoreView(),
                        buildActionButton(
                            'CLEAR',
                            () => ref
                                .read(gameController.notifier)
                                .clearNewScore()),
                      ],
                    ),
                  ),
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildActionButton(
                          'CHECKOUT',
                          () => ref
                              .read(gameController.notifier)
                              .checkoutPlayer(game.throwingPlayer.id),
                        ),
                        buildNumberButton(0),
                        buildActionButton(
                          game.newScore > 0 ? 'OK' : 'NO SCORE',
                          () => ref
                              .read(gameController.notifier)
                              .updatePlayerScore(game.throwingPlayer.id),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
