import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_color_controller.dart';

part 'theme.g.dart';

@riverpod
ThemeData theme(
  ThemeRef ref, {
  required Brightness brightness,
}) {
  final themeColor = ref.watch(themeColorControllerProvider);
  final baseTheme = ThemeData(
    brightness: brightness,
    useMaterial3: true,
    colorSchemeSeed: themeColor,
  );

  return baseTheme.copyWith(
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
  );
}
