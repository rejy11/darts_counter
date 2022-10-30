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

  Widget buildPlayerScoreView(Player player) {
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(
          width: double.infinity,
          height: double.infinity,
        ),
        child: Container(
          child: Stack(
            children: [
              player.isPlayersTurn
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
                  child: Text(
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

  Widget buildSubmitButton(Game game) {
    return game.newScore > 0
        ? buildActionButton(
            'OK',
            () {
              if (game.throwingPlayer == game.playerOne) {
                ref.read(gameController.notifier).updatePlayerOneScore();
              } else {
                ref.read(gameController.notifier).updatePlayerTwoScore();
              }
            },
          )
        : buildActionButton(
            'NO SCORE',
            () {
              if (game.throwingPlayer == game.playerOne) {
                ref.read(gameController.notifier).updatePlayerOneScore();
              } else {
                ref.read(gameController.notifier).updatePlayerTwoScore();
              }
            },
          );
  }

  //Evaluates whether the game has finished (a player has reached 0) and shows a dialog if true
  void evaluateGameState(Game game) {
    if (game.gameOver) {
      String winningPlayer;
      if (game.playerOne.remainingScore == 0) {
        winningPlayer = game.playerOne.name;
      } else {
        winningPlayer = game.playerTwo.name;
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Game Shot',
              textAlign: TextAlign.center,
            ),
            content: Text(
              '$winningPlayer wins!',
              textAlign: TextAlign.center,
            ),
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

    Player playerOne = game.playerOne;
    Player playerTwo = game.playerTwo;
    _newScoreController.text = game.newScore.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${playerOne.name} vs ${playerTwo.name}'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                buildPlayerScoreView(playerOne),
                buildPlayerScoreView(playerTwo),
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
                              .checkoutCurrentPlayer(),
                        ),
                        buildNumberButton(0),
                        buildSubmitButton(game),
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
