import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_font_sizes.dart';
import '../../utils/constants/app_font_weights.dart';
import '../../utils/constants/app_images.dart';
import 'custom_text.dart';

Future actionDiaglog(
  context, {
  required String title,
  subTitle,
  diaglogImage,
  required VoidCallback onSubmit,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Dialog(
            elevation: 0,
            clipBehavior: Clip.none,
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: 260,
              width: 290,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        AppAssets.logoutDiaglogBg,
                        height: 210,
                        color: AppColors.secondaryColor,
                        width: double.infinity,
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: 210,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: title,
                              color: AppColors.whiteColor,
                              fontSize: AppFontSize.screenTitle,
                              fontWeight: AppFontweight.extra_bold.font,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextWidget(
                              text: subTitle,
                              color: AppColors.subtitleColor,
                              fontSize: AppFontSize.discription,
                              fontWeight: AppFontweight.medium.font,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: AppColors.redColor),
                                    child: const Center(
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 20,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                                30.width,
                                InkWell(
                                  onTap: onSubmit,
                                  // AuthenticationRepository.instance.logout();
                                  // UpdateUserProfileController.instance
                                  //     .clearValues();
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0xff00A006)),
                                    child: const Center(
                                      child: Icon(
                                        Icons.done_rounded,
                                        size: 20,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondaryColor),
                      child: Center(
                        child: Container(
                          height: 65,
                          width: 65,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.redColor,
                          ),
                          child: Center(
                            child: Image.asset(
                              diaglogImage,
                              color: AppColors.whiteColor,
                              height: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Transform.translate(
                        offset: const Offset(0, -10),
                        child: Transform.scale(
                          scale: 2,
                          child: Image.asset(
                            AppAssets.logoutDiaglogConfeti,
                            height: 50,
                            width: double.infinity,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
