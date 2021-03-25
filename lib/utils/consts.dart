import 'dart:ui';

import 'package:flutter/material.dart';

import 'common.dart';

class AppConsts {
  static double heightSize;
  static double widthSize;

  static double heightPercentage;
  static double widthPercentage;

  static const double xdHeightSize = 667.0;
  static const double xdWidhtSize = 375.0;

  static void setHeightSize(double size) {
    heightSize = size;
    heightPercentage = heightSize / xdHeightSize;
  }

  static void setWidhtSize(double size) {
    widthSize = size;
    widthPercentage = widthSize / xdWidhtSize;
  }

  static Color backgroundColor = const Color(0xffffffff);
  static Color altBackgroundColor = const Color(0xffdddde5);
  static Color backgroundColorOpacity70 = const Color(0xb3eeeeff);
  static Color primaryColor = const Color(0xff46649C);
  static Color primaryColorOpacity12 = const Color(0x1f46649C);
  static Color primaryColorOpacity50 = const Color(0x8046649C);
  static Color textOnPrimary = const Color(0xffffffff);
  static Color textOnBackground = const Color(0xff46649C);
  static Color blurple = const Color(0xaf46649C);
  static Color disabledColor = const Color(0xff484848);
  static Color cornflower = const Color(0xff7b6cf6);
  static Color redBasic = const Color(0xffcf0305);
  static Color yellowBasic = const Color(0xffffff00);
  static Color greenBasic = const Color(0xff00ff00);
  static Color borderColor = Colors.black26;
  static Color black = const Color(0xff000000);

  static double fontSize08 = setWidth(8.0);
  static double fontSize09 = setWidth(9.0);
  static double fontSize10 = setWidth(10.0);

  static TextStyle styleTitle = TextStyle(
    color: AppConsts.black,
    fontWeight: FontWeight.w600,
    fontSize: AppConsts.fontSize10,
  );
}
