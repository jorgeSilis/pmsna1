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

  static ThemeData chillTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(scaffoldBackgroundColor: Color.fromARGB(232, 133, 113, 224),colorScheme: Theme.of(context).colorScheme.copyWith(
      primary: Color.fromARGB(167, 211, 42, 226),
      background: Colors.deepPurple[900],


    ));
  }


  
}
