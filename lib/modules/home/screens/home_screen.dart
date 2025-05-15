import 'package:darts_counter/modules/x01/screens/x01_settings_screen.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:darts_counter/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.screenPadding),
          child: Column(
            children: [
              const SizedBox(height: Spacing.xxl),
              Text(
                'Darts Counter',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: Spacing.xxl),
              PrimaryButton(
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
