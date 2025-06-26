import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:darts_counter/models/player.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:flutter/material.dart';

class PlayerScore extends StatelessWidget {
  final Player player;
  final bool isThrowingPlayer;
  final bool invalidScore;

  const PlayerScore({
    super.key,
    required this.player,
    required this.isThrowingPlayer,
    required this.invalidScore,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isThrowingPlayer ? 1 : 0.6,
      child: Card(
        // Explicitly set margin otherwise a default of 4 is applied:
        margin: const EdgeInsets.all(0),
        shape: const BeveledRectangleBorder(),
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: Spacing.l,
                  ),
                  child: Text(
                    player.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: invalidScore && isThrowingPlayer
                    ? const Text(
                        'BUST',
                        style: TextStyle(fontSize: 32),
                      )
                    : AnimatedNumberText(
                        player.remainingScore,
                        style: const TextStyle(fontSize: 32),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
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
          ],
        ),
      ),
    );
  }
}
