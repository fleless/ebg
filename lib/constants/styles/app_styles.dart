import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

/// This class provides custom styles to be used in the project.
///
class AppStyles {
  AppStyles._();

  static const subTitle = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.white,
    fontWeight: FontWeight.w900,
    fontSize: 36,
  );

  static const bodoniItalic = TextStyle(
    fontFamily: 'Bodoni',
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 40,
  );

  static const modifierStyle = TextStyle(
      fontFamily: 'Bodoni',
      color: AppColors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      decoration: TextDecoration.underline,
      decorationThickness: 2);

  static const listTileTitle = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.white,
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  static const listTileTitleBlack = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.appBackground,
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  static const listTileSubTitle = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.default_blue,
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  static const labelTextField = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.grey,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
}
