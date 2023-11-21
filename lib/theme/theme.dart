import 'package:flutter/foundation.dart';
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
    pageTransitionsTheme: PageTransitionsTheme(
      builders: kIsWeb
          ? {
              for (final platform in TargetPlatform.values)
                platform: const NoTransitionsBuilder(),
            }
          : {
              TargetPlatform.android: const ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
              TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
            },
    ),
  );

  return baseTheme.copyWith(
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
  );
}

/// アニメーションなしでページ遷移するための [PageTransitionsBuilder]。
class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    return child!;
  }
}
