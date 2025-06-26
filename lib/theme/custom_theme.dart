import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData light = FlexThemeData.dark(
    scheme: FlexScheme.indigoM3,

    //scaffoldBackground: Colors.grey[350],
    // subThemesData: const FlexSubThemesData(
    //   appBarForegroundSchemeColor: SchemeColor.white,
    //   appBarActionsIconSchemeColor: SchemeColor.white,
    // ),
  );
}
