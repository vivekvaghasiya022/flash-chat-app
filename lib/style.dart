import 'package:flutter/material.dart';

ThemeData appTheme(){
  return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        title: TextStyle(
          fontFamily: 'SofiaPro',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF000000),
        ),
        caption: TextStyle(
          fontFamily: 'SofiaPro',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF000000),
        ),
        subhead: TextStyle(
          fontFamily: 'SofiaPro',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF000000),
        ),
        body1: TextStyle(
          fontFamily: 'SofiaPro',
          fontSize: 17,
          fontWeight: FontWeight.normal,
          color: Color(0xFF000000),
        ),
      )
  );
}