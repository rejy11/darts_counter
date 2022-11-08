import 'package:darts_counter/dialogs/custom_alert_dialog.dart';
import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/pages/game_page.dart';
import 'package:darts_counter/providers/providers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
    ref.read(gameSettingsController.notifier).updateSettings(
          playerOneName: _playerOneNameController.text,
          playerTwoName: _playerTwoNameController.text,
        );
    await showDialog(
      context: context,
      builder: ((context) {
        return createAlertDialog(
          titleText: 'Throwing First',
          iconData: Icons.person,
          showDividers: false,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CANCEL'),
            ),
          ],
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, 1),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  child: Text(
                    _playerOneNameController.text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, 2),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  child: Text(
                    _playerTwoNameController.text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
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

  Widget buildPlayerNameWidget(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLength: 12,
      decoration: const InputDecoration(
        labelText: 'Player name',
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        hintText: 'Player name',
        suffix: Opacity(
          opacity: 0.6,
          child: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget buildStartingScoreWidget(List<int> startingScores, int startingScore) {
    return DropdownButton2<int>(
      value: startingScore,
      underline: const SizedBox(),
      buttonDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      buttonHeight: 60,
      icon: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.arrow_drop_down),
      ),
      onChanged: (value) {
        ref.read(gameSettingsController.notifier).updateSettings(
              startingScore: value,
              playerOneName: _playerOneNameController.text,
              playerTwoName: _playerTwoNameController.text,
            );
      },
      items: startingScores.map<DropdownMenuItem<int>>(
        (int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(value.toString()),
            ),
          );
        },
      ).toList(),
      focusColor: Colors.transparent,
      isExpanded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    GameSettings gameSettings = ref.watch(gameSettingsController);
    List<int> startingScores = ref.watch(startingScoresProvider);

    int startingScore = gameSettings.startingScore;
    _playerOneNameController.text = gameSettings.playerOne.name;
    _playerTwoNameController.text = gameSettings.playerTwo.name;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Game Settings"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                buildPlayerNameWidget(_playerOneNameController),
                buildPlayerNameWidget(_playerTwoNameController),
                buildStartingScoreWidget(startingScores, startingScore),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: startButtonPressed,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(60),
                  ),
                  child: const Text('START'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
