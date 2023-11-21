import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_color_controller.g.dart';

@riverpod
class ThemeColorController extends _$ThemeColorController {
  @override
  Color build() {
    return _getRandomColor();
  }

  Future<void> change([Color? color]) async {
    state = color ?? _getRandomColor();
  }
}

Color _getRandomColor() {
  final random = Random();
  final r = random.nextInt(256);
  final g = random.nextInt(256);
  final b = random.nextInt(256);
  return Color.fromRGBO(r, g, b, 1);
}
