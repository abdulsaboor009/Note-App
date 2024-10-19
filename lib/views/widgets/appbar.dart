import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/utils/constants/app_font_sizes.dart';
import 'package:notebox/utils/constants/app_font_weights.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/action_diaglog.dart';
import 'package:notebox/views/widgets/custom_text.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';

import '../../controllers/note controller/note_controller.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatelessWidget {
  final String title;
  bool showClearTrashButton;
  AppBarWidget(
      {super.key, required this.title, this.showClearTrashButton = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveSize.h * 105,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: ResponsiveSize.h * 45,
                        width: ResponsiveSize.w * 45,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: AppColors.whiteColor,
                            size: ResponsiveSize.h * 20,
                          ),
                        ),
                      ),
                    ),
                    20.width,
                    TextWidget(
                      color: AppColors.titleColor,
                      fontSize: AppFontSize.screenTitle,
                      fontWeight: AppFontweight.bold.font,
                      text: title,
                    )
                  ],
                ),
                showClearTrashButton
                    ? InkWell(
                        onTap: () {
                          actionDiaglog(context,
                              title: 'Clear Trash',
                              subTitle: 'Are you sure? You want to clear!',
                              onSubmit: () {
                            NoteController.instance.clearAllTrashNotes();
                          }, diaglogImage: AppAssets.delete);
                        },
                        child: Container(
                          height: ResponsiveSize.h * 45,
                          width: ResponsiveSize.w * 45,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                              child: Image.asset(
                            AppAssets.delete,
                            color: AppColors.whiteColor,
                            height: ResponsiveSize.h * 20,
                          )),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            16.height
          ],
        ),
      ),
    );
  }
}
