import 'package:flutter/material.dart';
import 'pallete.dart';

class AppTheme {
  
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Pallete.backgroundColorL,
    
    colorScheme: ColorScheme.light(
      surface: Pallete.lightPrimary,
      surfaceContainerHighest: const Color.fromARGB(255, 182, 182, 182), 
      surfaceContainerHigh: const Color.fromARGB(255, 80, 80, 80),
      surfaceContainerLow: Colors.white,
      surfaceContainer: Pallete.ButtonFillColorD1,
      primary: Pallete.lightPrimary, 
      inversePrimary: Pallete.lightPrimary,
      secondary: Pallete.textColorPrimaryL, 
      error: Pallete.errorColor, 
      onError: Colors.red, 
      onSurface: Pallete.fillColorL,
      primaryFixedDim: const Color.fromARGB(255, 199, 199, 199),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.blue),
      trackColor: WidgetStateProperty.all(Colors.blueAccent),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Pallete.fillColorL,
      hintStyle: TextStyle(
        color: Pallete.textColorPrimaryL,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Pallete.ButtonFillColorD1),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black
    ),

  );
  
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: Pallete.backgroundColorD,

    colorScheme: ColorScheme.dark(
      surface: Pallete.darkPrimary,
      surfaceContainerHighest: const Color.fromARGB(255, 36, 41, 43),  
      surfaceContainerHigh: const Color.fromARGB(255, 245, 245, 245),
      surfaceContainerLow: const Color.fromARGB(255, 35, 38, 39),
      surfaceContainer: Pallete.ButtonFillColorL1,
      primary: Pallete.lightPrimary,
      secondary: const Color.fromARGB(255, 219, 219, 219), 
      inversePrimary: Pallete.darkPrimary,
      error: Pallete.errorColor, 
      onError: Colors.red, 
      onSurface: Pallete.fillColorD,
      primaryFixedDim: Pallete.backButtonD,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 90, 90, 90),
      foregroundColor: Color.fromARGB(255, 95, 95, 95),
      elevation: 2,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.blueGrey),
      trackColor: WidgetStateProperty.all(Colors.blueAccent),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Pallete.fillColorD,
      hintStyle: TextStyle(
        color: Pallete.textColorPrimaryD,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Pallete.ButtonFillColorL1),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black
    ),

  );
  
}
