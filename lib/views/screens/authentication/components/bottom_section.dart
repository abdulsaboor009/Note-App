import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import '../../../../controllers/authentication controller/google_auth_controller.dart';

class GoogleAuthentBottomSection extends StatefulWidget {
  const GoogleAuthentBottomSection({super.key});

  @override
  State<GoogleAuthentBottomSection> createState() =>
      _GoogleAuthentBottomSectionState();
}

class _GoogleAuthentBottomSectionState
    extends State<GoogleAuthentBottomSection> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final googleAuthController = Get.put(GoogleAuthenticationController());
    return Obx(
      () => AnimatedPositioned(
        curve: Curves.easeIn,
        duration: Duration(
            milliseconds:
                googleAuthController.showUserNameField.value ? 1000 : 600),
        bottom: googleAuthController.showUserNameField.value
            ? -MediaQuery.of(context).size.height * 0.35
            : animate
                ? 0
                : -MediaQuery.of(context).size.height * 0.35,
        left: ResponsiveSize.w * 30,
        right: ResponsiveSize.w * 30,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: animate ? 1 : 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            // margin: EdgeInsets.symmetric(horizontal: ResponsiveSize.w * 30),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(30)),
              color: AppColors.secondaryColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(AppAssets.authBottomImage),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
