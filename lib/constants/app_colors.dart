import 'package:flutter/material.dart';

/// This class provides custom colors to be used in the project.
///
class AppColors {
  AppColors._();

  static const Color appBackground = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFF6D6D6D);
  static const Color list_background = Color(0xFF1C1C1C);
  static const Color default_blue = Color(0xFF0079E6);
  static const Color first_gradient_blue = Color(0xFF003B73);
  static const Color secondary_gradient_blue = Color(0xFF035BAD);
  static const Color third_gradient_blue = Color(0xFF007AE9);
  static const Color fourth_gradient_blue = Color(0xFF0091FF);
  static const Color grey = Color(0xFF727272);

  static Map<int, Color> colorCodes = {
    50: const Color.fromRGBO(0, 51, 153, .1),
    100: const Color.fromRGBO(0, 51, 153, .2),
    200: const Color.fromRGBO(0, 51, 153, .3),
    300: const Color.fromRGBO(0, 51, 153, .4),
    400: const Color.fromRGBO(0, 51, 153, .5),
    500: const Color.fromRGBO(0, 51, 153, .6),
    600: const Color.fromRGBO(0, 51, 153, .7),
    700: const Color.fromRGBO(0, 51, 153, .8),
    800: const Color.fromRGBO(0, 51, 153, .9),
    900: const Color.fromRGBO(0, 51, 153, 1),
  }; // Opacity 20%
}
