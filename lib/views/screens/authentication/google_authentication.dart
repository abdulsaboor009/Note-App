import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/controllers/authentication%20controller/google_auth_controller.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/responsive_sizes.dart';
import 'components/action_section.dart';
import 'components/bottom_section.dart';
import 'components/wellcome_section.dart';

class GoogleAuthenticationScreen extends StatelessWidget {
  const GoogleAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final googleAuthController = Get.put(GoogleAuthenticationController());
    return Obx(
      () => OverlayLoaderWithAppIcon(
        appIconSize: ResponsiveSize.h * 60,
        isLoading: googleAuthController.isLoading.value,
        overlayBackgroundColor: Colors.black,
        circularProgressColor: AppColors.whiteColor,
        appIcon: Image.asset(
          AppAssets.logo2Gif,
        ),
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: const Stack(
              children: [
                GoogleAuthentWellcomeSection(),
                GoogleAuthentBottomSection(),
                GoogleAuthentActionSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
