import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/responsive_sizes.dart';

class EditNoteAppBar extends StatelessWidget {
  final VoidCallback? onSave;
  const EditNoteAppBar({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                InkWell(
                  onTap: onSave,
                  // Get.back();
                  child: Container(
                    height: ResponsiveSize.h * 45,
                    width: ResponsiveSize.w * 45,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                        child: Image.asset(
                      AppAssets.save,
                      height: ResponsiveSize.h * 25,
                      color: AppColors.whiteColor,
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
