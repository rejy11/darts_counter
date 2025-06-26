import 'package:darts_counter/dialogs/custom_alert_dialog.dart';
import 'package:darts_counter/models/game_settings.dart';
import 'package:darts_counter/models/player.dart';
import 'package:darts_counter/modules/x01/state/x01_settings_state.dart';
import 'package:darts_counter/widgets/custom_text_button.dart';
import 'package:darts_counter/widgets/custom_text_field.dart';
import 'package:darts_counter/modules/x01/screens/x01_screen.dart';
import 'package:darts_counter/providers/providers.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:darts_counter/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class X01SettingsScreen extends ConsumerWidget {
  const X01SettingsScreen({super.key});

  Widget _buildPlayerButton({
    required BuildContext context,
    required Player player,
    required WidgetRef ref,
  }) {
    return CustomFilledButton(
      onPressed: () {
        ref
            .read(x01SettingsStateProvider.notifier)
            .updateSettings(startingPlayer: player);
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => const X01Screen())));
      },
      label: player.name,
      fontSize: 12,
      buttonHeight: 40,
    );
  }

  void _startButtonTapped(
      BuildContext context, GameSettings gameSettings, WidgetRef ref) async {
    await showDialog(
      context: context,
      builder: ((context) {
        return createAlertDialog(
          titleText: 'Throwing first',
          iconData: Icons.person,
          actions: [
            CustomTextButton(
              onPressed: () => Navigator.of(context).pop(),
              label: 'CANCEL',
            ),
          ],
          content: Row(
            children: [
              Flexible(
                child: _buildPlayerButton(
                  context: context,
                  player: gameSettings.players[0],
                  ref: ref,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: _buildPlayerButton(
                  context: context,
                  player: gameSettings.players[1],
                  ref: ref,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStartingScoreRadioButtons(WidgetRef ref) {
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
          .toList(),
    );
  }

  Widget _buildPlayerNameTextField({
    required WidgetRef ref,
    required Player player,
  }) {
    return CustomTextField(
      initialValue: player.name,
      hintText: 'Player name',
      labelText: 'Player name',
      onChanged: (value) {
        ref.read(x01SettingsStateProvider.notifier).updateSettings(
              player: player.copyWith(name: value),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GameSettings gameSettings = ref.watch(x01SettingsStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SETTINGS'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.screenPadding),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPlayerNameTextField(
                          ref: ref,
                          player: gameSettings.players[0],
                        ),
                        const SizedBox(height: Spacing.l),
                        _buildPlayerNameTextField(
                          ref: ref,
                          player: gameSettings.players[1],
                        ),
                        const SizedBox(height: Spacing.l),
                        Text(
                          'Starting score',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: Spacing.m),
                        _buildStartingScoreRadioButtons(ref),
                      ],
                    ),
                  ),
                ),
                CustomFilledButton(
                  onPressed: () =>
                      _startButtonTapped(context, gameSettings, ref),
                  label: 'START',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
