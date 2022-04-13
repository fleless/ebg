import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

LinearGradient buttonGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.first_gradient_blue,
      AppColors.secondary_gradient_blue,
      AppColors.third_gradient_blue,
      AppColors.fourth_gradient_blue
    ],
  );
}
