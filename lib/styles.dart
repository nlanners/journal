import 'package:flutter/material.dart';

class Styles {

  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 20.0;
  static const _textSizeSmall = 12.0;
  static const Color _textColorDefault = Colors.black;
  static const Color _textColorFaint = Colors.blueGrey;
  static const Color _textColorBright = Colors.white;
  static const Color _textColorSpecial = Colors.red;
  static const String _fontNameDefault = 'Roboto';

  static const navBarTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.w400,
    fontSize: _textSizeDefault,
    color: _textColorBright
  );

  static const headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.w700,
    fontSize: _textSizeLarge,
    color: _textColorFaint,
    shadows:[
      Shadow(
        color: Colors.black,
        blurRadius: 2,
        offset: Offset(2.5, 2)
      )
    ]
  );

  static const normalText = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: _textColorDefault
  );

  static const clickText = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: _textColorDefault,
    shadows:[
      Shadow(
        color: Colors.white,
        blurRadius: 3,
        offset: Offset(2.5, 2)
      )
    ]
  );

  static const responseText = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: _textColorBright,
    shadows:[
      Shadow(
        color: Colors.black,
        blurRadius: 5,
        offset: Offset(2.5, 2)
      )
    ]
  );

  static const titleText = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeDefault,
    color: _textColorSpecial,
    shadows: [
      Shadow(
        color: Colors.black,
        blurRadius: 5,
        offset: Offset(2.5, 2)
      )
    ]
  );

  static const jobText = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: _textColorDefault
  );

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );

}