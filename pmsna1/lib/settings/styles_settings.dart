import 'package:flutter/material.dart';

class StylesSettings {

  

  static ThemeData lightTheme(BuildContext context) {
    final theme = ThemeData.light();
    return theme.copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(
      primary: Color.fromARGB(255, 4, 113, 4)
    ));
  }

  static ThemeData darkTheme(BuildContext context) {
    final theme = ThemeData.dark();
    return theme.copyWith(colorScheme: Theme.of(context).colorScheme.copyWith(
      primary: Color.fromARGB(255, 71, 95, 77)
      ));
  }
}
