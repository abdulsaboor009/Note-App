import 'package:flutter/material.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/custom_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../utils/constants/app_font_sizes.dart';
import '../../utils/constants/app_font_weights.dart';
import 'shimmer_loader.dart';

class NotesCard extends StatelessWidget {
  final String title, content, time;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isImportant;
  const NotesCard(
      {super.key,
      required this.title,
      required this.content,
      required this.time,
      this.onPressed,
      required this.isLoading,
      this.isImportant = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: ResponsiveSize.h * 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.secondaryColor),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSize.w * 15,
              vertical: ResponsiveSize.h * 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? ShimmerEffectLoader(
                      width: ResponsiveSize.w * 60,
                      height: ResponsiveSize.w * 15)
                  : LimitedLinesText(
                      maxLine: 1,
                      color: AppColors.titleColor,
                      fontSize: AppFontSize.title - ResponsiveSize.setSp(1),
                      text: title,
                      fontWeight: AppFontweight.medium.font,
                    ),
              8.height,
              DottedLine(
                dashLength: 5,
                dashColor: AppColors.subtitleColor,
                lineThickness: 0.8,
                dashGapLength: 5,
              ),
              8.height,
              isLoading
                  ? Column(
                      children: [
                        ShimmerEffectLoader(
                            width: double.infinity,
                            height: ResponsiveSize.w * 12),
                        10.height,
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ShimmerEffectLoader(
                              width: double.infinity,
                              height: ResponsiveSize.w * 12),
                        ),
                        10.height,
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: ShimmerEffectLoader(
                              width: double.infinity,
                              height: ResponsiveSize.w * 12),
                        ),
                      ],
                    )
                  : LimitedLinesText(
                      maxLine: 4,
                      color: AppColors.subtitleColor,
                      fontSize: AppFontSize.smalldiscription +
                          ResponsiveSize.setSp(1),
                      text: content,
                      fontWeight: AppFontweight.normal.font,
                    ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isImportant
                      ? Image.asset(
                          AppAssets.favouriteFilled,
                          height: ResponsiveSize.h * 16,
                          color: AppColors.whiteColor,
                        )
                      : SizedBox(
                          height: ResponsiveSize.h * 18,
                        ),
                  Row(
                    children: [
                      isLoading
                          ? ShimmerEffectLoader(
                              width: ResponsiveSize.w * 60,
                              height: ResponsiveSize.w * 10)
                          : TextWidget(
                              color: AppColors.titleColor,
                              fontSize: AppFontSize.smalldiscription -
                                  ResponsiveSize.setSp(1.5),
                              text: time,
                              fontWeight: AppFontweight.normal.font,
                            ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
