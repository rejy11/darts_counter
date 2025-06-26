import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerStatefulWidget {
  const CustomTextField({
    super.key,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.onChanged,
  });

  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final Function(String value)? onChanged;

  @override
  ConsumerState<CustomTextField> createState() => _PlayerNameWidgetState();
}

class _PlayerNameWidgetState extends ConsumerState<CustomTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 12,
      decoration: InputDecoration(
        labelText: widget.labelText,
        //fillColor: Colors.transparent,
        border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
        hintText: widget.hintText,
        suffix: const Opacity(
          opacity: 0.4,
          child: Icon(Icons.person),
        ),
      ),
      onChanged: widget.onChanged,

      //style: TextStyle(color: Colors.white),
      // style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //       color: Theme.of(context).colorScheme.onSurface,
      //     ),
    );
  }
}
