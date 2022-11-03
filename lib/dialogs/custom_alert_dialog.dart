import 'package:flutter/material.dart';

AlertDialog createAlertDialog({
  required String titleText,
  required String bodyText,
  IconData? iconData,
  List<Widget>? actions,
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
        const Divider(),
        Text(bodyText),
        const Divider(),
      ],
    ),
    actions: actions,
  );
}
