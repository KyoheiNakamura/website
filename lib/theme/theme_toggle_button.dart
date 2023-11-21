import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'theme_builder.dart';
import 'theme_mode_controller.dart';

class ThemeToggleButton extends HookConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeBuilder(
      builder: (context, brightness) {
        return IconButton(
          onPressed: () {
            final oppositeMode = brightness == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light;
            ref
                .read(themeModeControllerProvider.notifier)
                .toggleTheme(oppositeMode);
          },
          icon: Icon(
            brightness == Brightness.light ? Icons.dark_mode : Icons.light_mode,
          ),
        );
      },
    );
  }
}
