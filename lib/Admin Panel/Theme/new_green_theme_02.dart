import 'package:flutter/material.dart';
/*

CFCFEA


 */

final ThemeData myTheme = ThemeData(
  primarySwatch: Colors.teal,
  brightness: Brightness.light,
  primaryColor: const Color(0xff009688),
  primaryColorLight: const Color(0xffb2dfdb),
  primaryColorDark: const Color(0xff00796b),
  secondaryHeaderColor: const Color(0xffe0f2f1),
  dividerTheme: const DividerThemeData(
    color: Colors.teal ,
  ),
  // elevatedButtonTheme: ,
  // dividerColor: Colors.yellow ,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: Color(0x8a000000),
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: Color(0x8a000000),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0x8a000000),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      color: Color(0x8a000000),
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xdd000000),
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      color: Color(0xdd000000),
    ),
    bodyLarge: TextStyle(
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
  // colorScheme: const ColorScheme.light(
  //   primary: Color(0xff009688),
  //   secondary: Color(0xff009688),
  //   surface: Color(0xffffffff),
  //   error: Color(0xffd32f2f),
  //   onPrimary: Color(0xffffffff),
  //   onSecondary: Color(0xffffffff),
  //   onSurface: Color(0xff000000),
  //   onError: Color(0xffffffff),
  // ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: 100,
    height: 36,
    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
    shape: StadiumBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.solid,
      ),
    ),
    alignedDropdown: true,
    buttonColor: Color(0xff009688),
    disabledColor: Color(0x61000000),
    highlightColor: Color(0x00000000),
    splashColor: Color(0x1fffffff),
    focusColor: Color(0xff009688),
    hoverColor: Color(0xff009688),
  ),
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
    errorMaxLines: null,
    isDense: false,
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: Color(0xdd000000),
    ),
    suffixStyle: TextStyle(
      color: Color(0xdd000000),
    ),
    counterStyle: TextStyle(
      color: Color(0xdd000000),
    ),
    filled: false,
    fillColor: Color(0x00000000), floatingLabelBehavior: FloatingLabelBehavior.auto,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      gapPadding: 4,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      gapPadding: 4,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      gapPadding: 4,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      gapPadding: 4,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      gapPadding: 4,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      gapPadding: 4,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xff009688),
    size: 32,
  ),
  primaryIconTheme: const IconThemeData(
    color: Color(0xffffffff),
    size: 12,
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorTextStyle: TextStyle(
      color: Color(0xffffffff),
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Color(0xff009688),
    unselectedLabelColor: Color(0xff009688),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: Color(0x1f000000),
    brightness: Brightness.light,
    deleteIconColor: Color(0xde000000),
    disabledColor: Color(0x0c000000),
    labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
    labelStyle: TextStyle(
      color: Color(0xde000000),
    ),
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    secondaryLabelStyle: TextStyle(
      color: Color(0x3d000000),
    ),
    secondarySelectedColor: Color(0x3d009688),
    selectedColor: Color(0x3d000000),
    shape: StadiumBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
    shape: BeveledRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
  ),
);
