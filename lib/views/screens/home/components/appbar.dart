import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/utils/constants/app_font_sizes.dart';
import 'package:notebox/utils/constants/app_font_weights.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/custom_text.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';

import '../../../../controllers/user controller/user_controller.dart';
import '../../../widgets/shimmer_loader.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  const HomeAppBar({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onMenuPressed,
              icon: Image.asset(
                AppAssets.menu,
                color: AppColors.whiteColor,
                height: ResponsiveSize.h * 30,
              ),
            ),
            10.width,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  color: AppColors.subtitleColor,
                  fontSize: AppFontSize.discription,
                  text: 'Welcome 👋',
                  fontWeight: AppFontweight.normal.font,
                ),
                Obx(() {
                  if (userController.profileLoading.value) {
                    return ShimmerEffectLoader(
                        width: ResponsiveSize.w * 130,
                        height: ResponsiveSize.w * 20);
                  } else {
                    String displayName = userController.user.value.name;
                    if (displayName.length > 8) {
                      // ignore: prefer_interpolation_to_compose_strings
                      displayName = displayName.substring(0, 12) + '...';
                    }
                    return TextWidget(
                      color: AppColors.titleColor,
                      fontSize: AppFontSize.largetitle,
                      text: displayName,
                      fontWeight: AppFontweight.bold.font,
                    );
                  }
                }),
              ],
            ))
          ],
        )
      ],
    );
  }
}
