import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:darts_counter/modules/home/screens/game_mode_screen.dart';
import 'package:darts_counter/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const int _totalSteps = 20;
  int _currentStep = 0;
  late AnimationController _progressBarController;
  double _progressBarOpacity = 0;

  @override
  void initState() {
    _progressBarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        if (_currentStep < 20) {
          setState(() {
            _currentStep++;
          });
        } else if (_currentStep == 20) {
          _progressBarController.stop();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const GameModeScreen()),
          );
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _progressBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Spacing.xxl),
              Row(
                children: [
                  Text(
                    '> ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Flexible(
                    child: AnimatedTextKit(
                      pause: const Duration(seconds: 0),
                      isRepeatingAnimation: false,
                      onFinished: () {
                        setState(() {
                          _progressBarOpacity = 1;
                        });
                        _progressBarController.forward();
                      },
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'darts_counter.exe',
                          speed: const Duration(milliseconds: 150),
                          textStyle: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.xl),
              Opacity(
                opacity: _progressBarOpacity,
                child: StepProgressIndicator(
                  totalSteps: _totalSteps,
                  currentStep: _currentStep,
                  size: 30,
                  selectedColor: Colors.amber,
                  unselectedColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
