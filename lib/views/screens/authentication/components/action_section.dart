import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/screens/navigation%20drawer/navigation_drawer.dart';
import 'package:notebox/views/widgets/custom_btn.dart';
import 'package:notebox/views/widgets/custom_textfield.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../../../controllers/authentication controller/google_auth_controller.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_font_sizes.dart';
import '../../../../utils/constants/app_font_weights.dart';
import '../../../../utils/validators/validator.dart';
import '../../../widgets/custom_text.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GoogleAuthentActionSection extends StatefulWidget {
  const GoogleAuthentActionSection({super.key});

  @override
  State<GoogleAuthentActionSection> createState() =>
      _GoogleAuthentActionSectionState();
}

class _GoogleAuthentActionSectionState
    extends State<GoogleAuthentActionSection> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final googleAuthController = Get.put(GoogleAuthenticationController());
    return Obx(
      () => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        googleAuthController.showUserNameField.value
            ? Animate(
                delay: const Duration(milliseconds: 1400),
                effects: const [
                  FadeEffect(),
                  ScaleEffect(),
                ],
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ResponsiveSize.w * 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      100.height,
                      TextWidget(
                        color: AppColors.titleColor,
                        fontSize: AppFontSize.largetitle,
                        text: 'Enter Your Name',
                        fontWeight: AppFontweight.bold.font,
                      ),
                      15.height,
                      Form(
                        key: googleAuthController.userNameFormKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveSize.w * 22),
                          child: customTextfield(
                            controller: googleAuthController.userName,
                            onValidator: (value) =>
                                Validator.validataNameText('Name', value),
                            textHorizentalSpacing: ResponsiveSize.w * 10,
                            maxLines: 1,
                            hint: 'Nick Name',
                            borderRadius: 12,
                            fillColor:
                                AppColors.secondaryColor.withOpacity(0.5),
                            borderColor: AppColors.secondaryColor,
                            borderWidth: 1.5,
                          ),
                        ),
                      ),
                      20.height,
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveSize.w * 22),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                  borderColor: AppColors.whiteColor,
                                  textColor: AppColors.whiteColor,
                                  buttonColor: Colors.transparent,
                                  borderwidth: 1.5,
                                  centerContent: 'Skip',
                                  onPressed: () {
                                    Get.offAll(
                                        () => const NavigationDrawerWidget());
                                    googleAuthController
                                        .showUserNameField.value = false;
                                  }),
                            ),
                            12.width,
                            Expanded(
                              child: CustomButton(
                                  centerContent: 'Submit',
                                  onPressed: () =>
                                      googleAuthController.getUserName()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: animate ? 1 : 0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ResponsiveSize.w * 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        textAlign: TextAlign.center,
                        color: AppColors.titleColor,
                        fontSize: AppFontSize.extralargetitle,
                        text:
                            'Welcome to NoteBox:\nSimplify Your Note-Taking Journey!',
                        fontWeight: AppFontweight.bold.font,
                      ),
                      25.height,
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveSize.w * 42),
                          child: CustomButton(
                              icon: Padding(
                                padding: EdgeInsets.only(
                                    right: ResponsiveSize.w * 10),
                                child: Image.asset(
                                  AppAssets.googleSignin,
                                  height: ResponsiveSize.h * 22,
                                ),
                              ),
                              centerContent: 'Get Started',
                              onPressed: () =>
                                  googleAuthController.googleAuthentication())),
                      50.height,
                    ],
                  ),
                ),
              )
      ]),
    );
  }
}
