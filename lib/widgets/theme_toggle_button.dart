import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controllers/theme_mode_controller.dart';
import '../extensions/context.dart';
import 'logo_button.dart';

class ThemeToggleButton extends HookConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => ref
          .read(themeModeControllerProvider.notifier)
          .toggleTheme(context.isDarkMode ? ThemeMode.light : ThemeMode.dark),
      icon: Icon(
        context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
        size: logoButtonSize,
      ),
    );
  }
}
