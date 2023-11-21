import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'theme_mode_controller.dart';

// class ThemeBuilder extends HookConsumerWidget {
//   const ThemeBuilder({
//     super.key,
//     required this.lightWidget,
//     required this.darkWidget,
//   });

//   final Widget lightWidget;
//   final Widget darkWidget;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeMode = ref.watch(themeModeControllerProvider);
//     final systemMode = View.of(context).platformDispatcher.platformBrightness;

//     return switch (themeMode) {
//       ThemeMode.light => lightWidget,
//       ThemeMode.dark => darkWidget,
//       ThemeMode.system =>
//         systemMode == Brightness.light ? lightWidget : darkWidget,
//     };
//   }
// }

typedef ThemeWidgetBuilder = Widget Function(
  BuildContext context,
  Brightness brightness,
);

class ThemeBuilder extends HookConsumerWidget {
  const ThemeBuilder({
    super.key,
    required this.builder,
  });

  final ThemeWidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final systemMode = View.of(context).platformDispatcher.platformBrightness;

    return switch (themeMode) {
      ThemeMode.light => builder(context, Brightness.light),
      ThemeMode.dark => builder(context, Brightness.dark),
      ThemeMode.system => systemMode == Brightness.light
          ? builder(context, Brightness.light)
          : builder(context, Brightness.dark)
    };
  }
}

// typedef ThemeWidgetBuilder = Widget Function(
//   BuildContext context,
//   ThemeMode themeMode,
//   Brightness systemMode,
// );

// class ThemeBuilder extends HookConsumerWidget {
//   const ThemeBuilder({
//     super.key,
//     required this.lightBuilder,
//     required this.darkBuilder,
//   });

//   final ThemeWidgetBuilder lightBuilder;
//   final ThemeWidgetBuilder darkBuilder;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final themeMode = ref.watch(themeModeControllerProvider);
//     final systemMode = View.of(context).platformDispatcher.platformBrightness;

//     Widget buildLightWidget() => lightBuilder(
//           context,
//           themeMode,
//           systemMode,
//         );
//     Widget buildDarkWidget() => darkBuilder(
//           context,
//           themeMode,
//           systemMode,
//         );

//     return switch (themeMode) {
//       ThemeMode.light => buildLightWidget(),
//       ThemeMode.dark => buildDarkWidget(),
//       ThemeMode.system =>
//         systemMode == Brightness.light ? buildLightWidget() : buildDarkWidget()
//     };
//   }
// }
