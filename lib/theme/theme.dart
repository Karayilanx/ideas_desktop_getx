import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData ideasTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xff223540),
    fontFamily: GoogleFonts.gothicA1().fontFamily,
    primaryColorLight: const Color(0xff223540),
    primaryColorDark: const Color(0xff6b4d2e),
    canvasColor: const Color(0xfffafafa),
    scaffoldBackgroundColor: const Color(0xff223540),
    cardColor: const Color(0xffffffff),
    dividerColor: const Color(0x1f000000),
    highlightColor: const Color(0x66bcbcbc),
    splashColor: const Color(0x66c8c8c8),
    unselectedWidgetColor: const Color(0x8a000000),
    disabledColor: const Color(0x61000000),
    secondaryHeaderColor: const Color(0xfff7f2ed),
    dialogBackgroundColor: const Color(0xffffffff),
    indicatorColor: const Color(0xffb3804c),
    hintColor: const Color(0x8a000000),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      minWidth: 88,
      height: 36,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xff000000),
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      alignedDropdown: false,
      buttonColor: Color(0xffe0e0e0),
      disabledColor: Color(0x61000000),
      highlightColor: Color(0x29000000),
      splashColor: Color(0x1f000000),
      focusColor: Color(0x1f000000),
      hoverColor: Color(0x0a000000),
      colorScheme: ColorScheme(
        primary: Color(0xff223540),
        secondary: Color(0xFFEDEAE6),
        surface: Color(0xffffffff),
        background: Color(0xffe1ccb7),
        error: Color(0xffd32f2f),
        onPrimary: Color(0xff000000),
        onSecondary: Color(0xffffffff),
        onSurface: Color(0xff000000),
        onBackground: Color(0xff000000),
        onError: Color(0xffffffff),
        brightness: Brightness.light,
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Colors.black, fontSize: 14),
      headlineSmall: TextStyle(color: Colors.black, fontSize: 16),
      headlineMedium: TextStyle(color: Colors.black, fontSize: 22),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(
        fontSize: 14.0,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xff8f673d);
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xff8f673d);
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xff8f673d);
        }
        return null;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xff8f673d);
        }
        return null;
      }),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xffffffff)),
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: const MaterialColor(4291009394, {
      50: Color(0xfff7f2ed),
      100: Color(0xfff0e6db),
      200: Color(0xffe1ccb7),
      300: Color(0xffd1b394),
      400: Color(0xffc29a70),
      500: Color(0xffb3804c),
      600: Color(0xff8f673d),
      700: Color(0xff6b4d2e),
      800: Color(0xff48331e),
      900: Color(0xff241a0f)
    }))
        .copyWith(secondary: const Color(0xffb3804c))
        .copyWith(background: const Color(0xffe1ccb7))
        .copyWith(error: const Color(0xffd32f2f)));
