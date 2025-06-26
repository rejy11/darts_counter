import 'package:flutter/material.dart';

AlertDialog createAlertDialog({
  required String titleText,
  Widget? content,
  IconData? iconData,
  List<Widget>? actions,
}) {
  return AlertDialog(
    shape: const BeveledRectangleBorder(),
    icon: iconData != null ? Icon(iconData) : null,
    title: Text(
      titleText,
      textAlign: TextAlign.center,
    ),
    content: content,
    actions: actions,
    actionsAlignment: MainAxisAlignment.end,
  );
}
