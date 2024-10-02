import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primarySwatch: Colors.teal,
  brightness: Brightness.light,
  primaryColor: const Color(0xff009688),
  primaryColorLight: const Color(0xffb2dfdb),
  primaryColorDark: const Color(0xff00796b),
  canvasColor: const Color(0xfffafaf9),
  scaffoldBackgroundColor: const Color(0xfffafafa),
  cardColor: const Color(0xfffffff1),
  dividerColor: const Color(0x1f000000),
  highlightColor: const Color(0x66bcbcbc),
  splashColor: const Color(0x66c8c8c8),
  unselectedWidgetColor: const Color(0x8a000000),
  disabledColor: const Color(0x61000000),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    buttonColor: Color(0xffe0e0e0),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x29000000),
    splashColor: Color(0x1f000000),
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xff009688),
    primaryContainer: Color(0xff00796b),
    secondary: Color(0xff009688),
    secondaryContainer: Color(0xff00796b),
    surface: Color(0xffffffff),
    // ignore: deprecated_member_use
    background: Color(0xff80cbc4),
    error: Color(0xffd32f2f),
    onPrimary: Color(0xffffffff),
    onSecondary: Color(0xffffffff),
    onSurface: Color(0xff000000),
    // ignore: deprecated_member_use
    onBackground: Color(0xffffffff),
    onError: Color(0xffffffff),
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color(0x8a000000),
    ),
    displayMedium: TextStyle(
      color: Color(0x8a000000),
    ),
    displaySmall: TextStyle(
      color: Color(0x8a000000),
    ),
    headlineMedium: TextStyle(
      color: Color(0xdd000000),
    ),
    headlineSmall: TextStyle(
      color: Color(0xdd000000),
    ),
    titleLarge: TextStyle(
      color: Color(0xdd000000),
    ),
    bodyLarge: TextStyle(
      color: Color(0xdd000000),
    ),
    bodyMedium: TextStyle(
      color: Color(0xdd000000),
    ),
    titleMedium: TextStyle(
      color: Color(0xdd000000),
    ),
    bodySmall: TextStyle(
      color: Color(0x8a000000),
    ),
    labelLarge: TextStyle(
      color: Color(0xdd000000),
    ),
    titleSmall: TextStyle(
      color: Color(0xff000000),
    ),
    labelSmall: TextStyle(
      color: Color(0xff000000),
    ),
  ),
  primaryTextTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color(0xb3ffffff),
    ),
    displayMedium: TextStyle(
      color: Color(0xb3ffffff),
    ),
    displaySmall: TextStyle(
      color: Color(0xb3ffffff),
    ),
    headlineMedium: TextStyle(
      color: Color(0xffffffff),
    ),
    headlineSmall: TextStyle(
      color: Color(0xffffffff),
    ),
    titleLarge: TextStyle(
      color: Color(0xffffffff),
    ),
    bodyLarge: TextStyle(
      color: Color(0xffffffff),
    ),
    bodyMedium: TextStyle(
      color: Color(0xffffffff),
    ),
    titleMedium: TextStyle(
      color: Color(0xffffffff),
    ),
    bodySmall: TextStyle(
      color: Color(0xb3ffffff),
    ),
    labelLarge: TextStyle(
      color: Color(0xffffffff),
    ),
    titleSmall: TextStyle(
      color: Color(0xffffffff),
    ),
    labelSmall: TextStyle(
      color: Color(0xffffffff),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.teal,
  ),
  // primaryIconTheme: const IconThemeData(
  //   color: Colors.teal,
  // ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xdd000000),
    ),
    helperStyle: TextStyle(
      color: Color(0xdd000000),
    ),
    hintStyle: TextStyle(
      color: Color(0xdd000000),
    ),
    errorStyle: TextStyle(
      color: Color(0xdd000000),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 12),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000)),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000)),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000)),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000)),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff000000)),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.symmetric(horizontal: 8),
    labelStyle: TextStyle(
      color: Color(0xde000000),
    ),
    padding: EdgeInsets.all(4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
    ),
    secondarySelectedColor: Color(0x3d009688),
    selectedColor: Color(0x3d000000),
    shape: StadiumBorder(
      side: BorderSide.none,
    ),
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
    ),
  ), bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xffffffff)),
);

