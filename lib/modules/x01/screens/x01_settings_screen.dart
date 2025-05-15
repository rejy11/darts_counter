import 'package:darts_counter/dialogs/custom_alert_dialog.dart';
import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/models/player.dart';
import 'package:darts_counter/modules/x01/state/x01_settings_state.dart';
import 'package:darts_counter/widgets/custom_text_field.dart';
import 'package:darts_counter/modules/x01/screens/x01_screen.dart';
import 'package:darts_counter/providers/providers.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:darts_counter/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class X01SettingsScreen extends ConsumerWidget {
  const X01SettingsScreen({super.key});

  void startButtonPressed(
      BuildContext context, GameSettings gameSettings, WidgetRef ref) async {
    void startGame(Player playerToThrowFirst) {
      ref
          .read(x01SettingsStateProvider.notifier)
          .updateSettings(startingPlayer: playerToThrowFirst);
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => const X01Screen())));
    }

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
                  onPressed: () => startGame(gameSettings.players[0]),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  child: Text(
                    gameSettings.players[0].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: ElevatedButton(
                  onPressed: () => startGame(gameSettings.players[1]),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  child: Text(
                    gameSettings.players[1].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildStartingScoreRadioButtons(WidgetRef ref) {
    return Column(
        children: ref
            .watch(startingScoresProvider)
            .map(
              (startingScore) => RadioListTile(
                title: Text(startingScore.toString()),
                value: startingScore,
                groupValue: ref.read(x01SettingsStateProvider).startingScore,
                onChanged: (value) {
                  ref
                      .read(x01SettingsStateProvider.notifier)
                      .updateSettings(startingScore: value);
                },
              ),
            )
            .toList());
  }

  Widget buildStartingScoreWidget(List<int> startingScores, WidgetRef ref) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: DropdownButton<int>(
        value: ref.read(x01SettingsStateProvider).startingScore,
        items: startingScores
            .map<DropdownMenuItem<int>>((value) => DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                ))
            .toList(),
        onChanged: (value) {
          ref
              .read(x01SettingsStateProvider.notifier)
              .updateSettings(startingScore: value);
        },
        itemHeight: 60,
        isExpanded: true,
        underline: const SizedBox(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GameSettings gameSettings = ref.watch(x01SettingsStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          titleTextStyle: Theme.of(context).textTheme.headlineLarge,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Spacing.screenPadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Spacing.xxl),
                  CustomTextField(
                    initialValue: gameSettings.players[0].name,
                    hintText: 'Player name',
                    labelText: 'Player name',
                    onChanged: (value) {
                      final Player updatedPlayer =
                          gameSettings.players[0].copyWith(name: value);
                      ref
                          .read(x01SettingsStateProvider.notifier)
                          .updateSettings(player: updatedPlayer);
                    },
                  ),
                  CustomTextField(
                    initialValue: gameSettings.players[1].name,
                    hintText: 'Player name',
                    labelText: 'Player name',
                    onChanged: (value) {
                      final Player updatedPlayer =
                          gameSettings.players[1].copyWith(name: value);
                      ref
                          .read(x01SettingsStateProvider.notifier)
                          .updateSettings(player: updatedPlayer);
                    },
                  ),
                  const SizedBox(height: Spacing.xl),
                  Text(
                    'Starting score',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: Spacing.xl),
                  buildStartingScoreRadioButtons(ref),
                  const SizedBox(height: Spacing.xl),
                  PrimaryButton(
                    onPressed: () =>
                        startButtonPressed(context, gameSettings, ref),
                    label: 'START',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
