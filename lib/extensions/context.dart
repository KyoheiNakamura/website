import 'package:flutter/material.dart';

extension BuildContextEx on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorTheme => theme.colorScheme;
  IconThemeData get iconTheme => theme.iconTheme;
  bool get isDarkMode => colorTheme.brightness == Brightness.dark;
  AppBarTheme get appBarTheme => theme.appBarTheme;
  NavigationBarThemeData get navigationBarTheme => theme.navigationBarTheme;

  // MediaQuery
  Size get mediaSize => MediaQuery.sizeOf(this);
  double get mediaHeight => mediaSize.height;
  double get mediaWidth => mediaSize.width;
  EdgeInsets get mediaPadding => MediaQuery.paddingOf(this);
  double get mediaPt => mediaPadding.top;
  double get mediaPb => mediaPadding.bottom;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
}
