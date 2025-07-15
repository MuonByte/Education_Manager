
import 'package:flutter/material.dart';
import 'pallete.dart';

class AppTheme {

  static OutlineInputBorder _border(Color color, double bradius) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(bradius),
        borderSide: BorderSide(
          color: color,
        ),
  );
  static final darkThemeM = ThemeData.dark().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(15),
      enabledBorder: _border(Pallete.borderColor2, 10),
      focusedBorder: _border(Pallete.borderColor1, 5),
    ),
  );

}
