import 'package:darts_counter/pages/game_settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Darts Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('New Game'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GameSettingsPage()));
          },
        ),
      ),
    );
  }
}
