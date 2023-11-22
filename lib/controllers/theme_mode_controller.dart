import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/shared_preferences.dart';

part 'theme_mode_controller.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  static const _key = 'themeMode';
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  ThemeMode build() {
    final storedMode = _prefs.getString(_key) ?? ThemeMode.system.name;
    return ThemeMode.values.firstWhere(
      (e) => e.name == storedMode,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    await _prefs.setString(_key, mode.name);
    state = mode;
  }
}
