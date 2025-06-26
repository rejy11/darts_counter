import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
    this.context, {
    super.automaticallyImplyLeading,
    super.title,
    super.key,
    super.actions,
    this.systemNavigationBarColor,
    super.flexibleSpace,
    super.toolbarHeight,
    super.centerTitle,
  });

  final BuildContext context;
  final Color? systemNavigationBarColor;

  @override
  Color? get backgroundColor => Colors.blue[800];

  @override
  SystemUiOverlayStyle? get systemOverlayStyle => const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.deepPurple,
      );

  @override
  IconThemeData? get iconTheme => const IconThemeData(color: Colors.white);
}
