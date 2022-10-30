import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/pages/game_page.dart';
import 'package:darts_counter/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game_settings_state.dart';

class GameSettingsPage extends ConsumerStatefulWidget {
  const GameSettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      GameSettingsPageState();
}

class GameSettingsPageState extends ConsumerState<GameSettingsPage> {
  late TextEditingController _playerOneNameController;
  late TextEditingController _playerTwoNameController;

  @override
  void initState() {
    super.initState();
    _playerOneNameController = TextEditingController();
    _playerTwoNameController = TextEditingController();
  }

  void startButtonPressed() async {
    ref
        .read(gameSettingsController.notifier)
        .updatePlayerOneName(_playerOneNameController.text);
    ref
        .read(gameSettingsController.notifier)
        .updatePlayerTwoName(_playerTwoNameController.text);
    await showDialog(
      context: context,
      builder: ((context) {
        return SimpleDialog(
          title: const Text(
            'Throwing first',
            textAlign: TextAlign.center,
          ),
          children: [
            SimpleDialogOption(
              child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, 1),
                  child: Text(_playerOneNameController.text)),
            ),
            SimpleDialogOption(
              child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, 2),
                  child: Text(_playerTwoNameController.text)),
            ),
          ],
        );
      }),
    ).then((value) {
      if (value != null) {
        if (value == 1) {
          ref.read(gameSettingsController.notifier).updatePlayersTurn(1);
        } else if (value == 2) {
          ref.read(gameSettingsController.notifier).updatePlayersTurn(2);
        }
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const GamePage())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GameSettings gameSettings = ref.watch(gameSettingsController);
    List<int> startingScores = ref.watch(startingScoresProvider);

    int startingScore = gameSettings.startingScore;
    _playerOneNameController.text = gameSettings.playerOne.name;
    _playerTwoNameController.text = gameSettings.playerTwo.name;

    return Scaffold(
      appBar: AppBar(title: const Text("Game Settings")),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: _playerOneNameController,
              ),
              TextField(
                controller: _playerTwoNameController,
              ),
              DropdownButton<int>(
                value: startingScore,
                onChanged: (value) {
                  ref
                      .read(gameSettingsController.notifier)
                      .updateStartingScore(value!);
                },
                items: startingScores.map<DropdownMenuItem<int>>(
                  (int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  },
                ).toList(),
                focusColor: Colors.transparent,
                isExpanded: true,
              ),
              ElevatedButton(
                onPressed: startButtonPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
