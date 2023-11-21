import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'home.dart';
import 'theme/theme.dart';
import 'theme/theme_mode_controller.dart';

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightTheme = ref.watch(themeProvider(brightness: Brightness.light));
    final darkTheme = ref.watch(themeProvider(brightness: Brightness.dark));
    final themeMode = ref.watch(themeModeControllerProvider);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const Home(),
    );
  }
}
