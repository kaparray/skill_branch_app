import 'package:flutter/widgets.dart';

import 'colors.dart';

class AppStyles {
  static const h6 = TextStyle(
    fontSize: 12,
    height: 20 / 12,
    letterSpacing: -0.24,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );

  static const h5Black = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
    fontStyle: FontStyle.normal,
    fontFamily: 'Roboto',
  );

  static const h4 = TextStyle(
    fontSize: 14,
    height: 16 / 14,
    color: AppColors.alto,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    letterSpacing: 0.75,
  );

  static const h3 = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.manatee,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    letterSpacing: 0.25,
  );

  static const h2Black = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontFamily: 'Roboto',
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.41,
  );

  static const h1Black = TextStyle(
    fontSize: 18,
    height: 23 / 18,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );
}
