import 'package:darts_counter/modules/x01/screens/x01_settings_screen.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:darts_counter/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';

class GameModeScreen extends StatelessWidget {
  const GameModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAME MODE'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.screenPadding),
          child: Column(
            children: [
              CustomFilledButton(
                label: 'X01',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const X01SettingsScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
