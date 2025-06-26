import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.onPressed,
    required this.label,
    this.buttonHeight = 60,
    this.fontSize = 24,
  });

  final VoidCallback? onPressed;
  final String label;
  final double buttonHeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.indigo[300],
        minimumSize: Size.fromHeight(buttonHeight),
        shape: const BeveledRectangleBorder(),
        side: const BorderSide(
          color: Colors.black,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
