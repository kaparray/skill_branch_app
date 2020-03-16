import 'package:flutter/widgets.dart';

import 'colors.dart';

class AppStyles {
  static const textBlack1 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    height: 18 / 13,
    color: AppColors.black,
    fontStyle: FontStyle.normal,
    fontFamily: 'Roboto',
  );

  static const textBlack2 = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontSize: 18,
    height: 23 / 18,
  );

  static const text3 = TextStyle(
    letterSpacing: -0.24,
    fontSize: 12,
    height: 20 / 12,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );

  static const text4 = TextStyle(
    height: 22 / 17,
    fontSize: 17,
    fontFamily: 'Roboto',
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.41,
  );

  static const text5 = TextStyle(
    color: AppColors.manatee,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.25,
  );

  static const text6 = TextStyle(
    color: AppColors.alto,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    fontSize: 14,
    height: 16 / 14,
    letterSpacing: 0.75,
  );
}
