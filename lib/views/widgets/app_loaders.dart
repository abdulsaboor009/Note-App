import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_font_sizes.dart';
import 'package:notebox/utils/constants/app_font_weights.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/custom_text.dart';

import '../../utils/constants/app_colors.dart';

class Loaders {
  static warningSnackbar({required title, message = ''}) {
    Get.snackbar(title, message,
        borderRadius: 12,
        titleText: Transform.translate(
          offset: const Offset(0, 13),
          child: TextWidget(
            color: AppColors.whiteColor,
            fontSize: AppFontSize.discription,
            fontWeight: AppFontweight.semi_bold.font,
            text: title,
          ),
        ),
        messageText: TextWidget(
          color: AppColors.whiteColor,
          fontSize: AppFontSize.smalldiscription,
          fontWeight: AppFontweight.normal.font,
          text: message,
        ),
        isDismissible: true,
        shouldIconPulse: true,
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.w * 10, vertical: ResponsiveSize.h * 8),
        colorText: AppColors.whiteColor,
        backgroundColor: AppColors.secondaryColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.w * 10),
          child: Transform.scale(
            scale: 1.3,
            child: Transform.translate(
              offset: const Offset(3, 0),
              child: Image.asset(
                AppAssets.warning,
                height: ResponsiveSize.h * 35,
              ),
            ),
          ),
        ));
  }

  static errorSnackbar({required title, message = ''}) {
    Get.snackbar(title, message,
        titleText: TextWidget(
          color: AppColors.whiteColor,
          fontSize: AppFontSize.discription,
          fontWeight: AppFontweight.semi_bold.font,
          text: title,
        ),
        messageText: TextWidget(
          color: AppColors.whiteColor,
          fontSize: AppFontSize.smalldiscription,
          fontWeight: AppFontweight.normal.font,
          text: message,
        ),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: AppColors.whiteColor,
        backgroundColor: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.w * 10, vertical: ResponsiveSize.h * 8),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.w * 10),
          child: Transform.scale(
            scale: 1.3,
            child: Transform.translate(
              offset: const Offset(3, 0),
              child: Image.asset(
                AppAssets.error,
                height: ResponsiveSize.h * 35,
              ),
            ),
          ),
        ));
  }

  static sucessSnackbar({required title, message = ''}) {
    Get.snackbar(title, message,
        titleText: TextWidget(
          color: AppColors.whiteColor,
          fontSize: AppFontSize.discription,
          fontWeight: AppFontweight.semi_bold.font,
          text: title,
        ),
        isDismissible: true,
        shouldIconPulse: true,
        messageText: TextWidget(
          color: AppColors.whiteColor,
          fontSize: AppFontSize.smalldiscription,
          fontWeight: AppFontweight.normal.font,
          text: message,
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        colorText: AppColors.whiteColor,
        backgroundColor: AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveSize.w * 10, vertical: ResponsiveSize.h * 8),
        margin: const EdgeInsets.all(20),
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveSize.w * 10),
          child: Transform.scale(
            scale: 1.3,
            child: Transform.translate(
              offset: const Offset(3, 0),
              child: Image.asset(
                AppAssets.sucess,
                height: ResponsiveSize.h * 35,
              ),
            ),
          ),
        ));
  }
}
