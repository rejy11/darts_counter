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
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3, bottom: 5),
        child: ConstrainedBox(
          constraints: const BoxConstraints.tightFor(
            width: double.infinity,
            height: double.infinity,
          ),
          child: Card(
            elevation: 1,
            color: Colors.white,
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
        ),
      ),
    );
  }

  Widget buildNumberButton(int value) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              ref.read(gameController.notifier).updateNewScore(value);
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: const BorderSide(width: 0, color: Colors.transparent),
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
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

  Widget buildActionButton(String actionText, Function()? action, {Color? backgroundColor, Color? foregroundColor}) {
    return Flexible(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: const BorderSide(color: Colors.transparent, width: 0),
              backgroundColor: backgroundColor ?? Colors.blueGrey[400],
              foregroundColor: foregroundColor ?? Colors.white,
            ),
            onPressed: action,
            child: Text(
              actionText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNewScoreView() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: _newScoreController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24),
              readOnly: true,
            ),
          ),
          // const Divider(indent: 40, endIndent: 40, color: Colors.black38,),
        ],
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
                    ref.read(gameController.notifier).restart();
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
            content: Text('$winningPlayer wins!'),
            iconData: CommunityMaterialIcons.bullseye_arrow,
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(gameController.notifier).undoPreviousScore();
                  Navigator.pop(context);
                },
                child: const Text('UNDO'),
              ),
              TextButton(
                onPressed: () {
                  ref.read(gameController.notifier).restart();
                  Navigator.pop(context);
                },
                child: const Text('RESTART'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
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
                  // const Divider(height: 1),
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
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.black,
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
