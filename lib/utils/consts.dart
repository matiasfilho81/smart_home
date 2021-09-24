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

  static double radiusBotton = 50;

  // Back Ground Colors

  static Color backgroundColor = const Color(0xff484848);
  static Color appbarBackgroundColor = const Color(0xff484848);

  // Cores básicas

  static Color redBasic = const Color(0xffcf0305);
  static Color yellowBasic = const Color(0xffffff00);
  static Color greenBasic = const Color(0xff00ff00);
  static Color borderColor = Colors.black26;
  static Color black = const Color(0xff000000);

  // ON/OFF
  static Color onColor = const Color(0xff7b6cf6);
  static Color offColor = const Color(0xff484848);
  static Color onBottom = const Color(0xffffffdd);
  static Color offBottom = const Color(0xffffdddd);
  static Color onText = const Color(0xffffffff);
  static Color offText = const Color(0xffffffdd);

  static double fontSize08 = setWidth(8.0);
  static double fontSize09 = setWidth(9.0);
  static double fontSize10 = setWidth(10.0);

  static TextStyle styleTitle = TextStyle(
    color: AppConsts.black,
    fontWeight: FontWeight.w600,
    fontSize: AppConsts.fontSize10,
  );

  static double topHeight = 10.0;
}
