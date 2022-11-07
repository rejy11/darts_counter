import 'dart:io';

import 'package:darts_counter/pages/game_settings_page.dart';
import 'package:darts_counter/pages/home_page.dart';
import 'package:darts_counter/theme/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isWindows || Platform.isLinux || Platform.isMacOS){
    setWindowTitle('Simple Darts');
    setWindowMinSize(const Size(480, 720));
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const GameSettingsPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        appBarTheme: AppBarTheme(
           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),        
        useMaterial3: true,
      ),
    );
  }
}
