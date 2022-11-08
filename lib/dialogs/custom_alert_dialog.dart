import 'package:flutter/material.dart';

AlertDialog createAlertDialog({
  required String titleText,
  required Widget content,
  IconData? iconData,
  List<Widget>? actions,
  bool showDividers = true,
}) {
  return AlertDialog(
    title: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconData != null
            ? Opacity(
                opacity: 0.7,
                child: Icon(iconData),
              )
            : const SizedBox(),
        Text(
          titleText,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        showDividers ? const Divider() : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: content,
        ),
        showDividers ? const Divider() : const SizedBox(),
      ],
    ),
    actions: actions,
    actionsAlignment: MainAxisAlignment.end,
  );
}
