import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/controllers/note%20controller/note_controller.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/screens/all%20notes/all_notes.dart';
import 'package:notebox/views/screens/starred%20notes/starred_notes.dart';
import 'package:notebox/views/widgets/custom_btn.dart';
import 'package:notebox/views/widgets/shimmer_loader.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../../../utils/constants/app_font_sizes.dart';
import '../../../../utils/constants/app_font_weights.dart';
import '../../../widgets/custom_text.dart';

class HomeOverview extends StatelessWidget {
  const HomeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.put(NoteController());
    return Obx(() {
      return Column(
        children: [
          Row(
            children: [
              overviewCard(
                  title: 'Total Notes',
                  numOfNotes: noteController.totalNotesCount.value.toString(),
                  onPressed: () {
                    Get.to(() => const AllNotesScreen());
                  },
                  isLoadingCount: noteController.isLoading.value),
              12.width,
              overviewCard(
                  title: 'Starred Notes',
                  numOfNotes: noteController.starredNotesCount.value.toString(),
                  onPressed: () {
                    Get.to(() => const StarredNotesScreen());
                  },
                  isLoadingCount: noteController.isLoading.value),
            ],
          ),
        ],
      );
    });
  }

  Widget overviewCard({
    String? title,
    String? numOfNotes,
    final VoidCallback? onPressed,
    required bool isLoadingCount,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondaryColor),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveSize.w * 15,
                vertical: ResponsiveSize.h * 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  color: AppColors.subtitleColor,
                  fontSize: AppFontSize.title,
                  text: title,
                  fontWeight: AppFontweight.medium.font,
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isLoadingCount
                        ? ShimmerEffectLoader(
                            width: ResponsiveSize.w * 30,
                            height: ResponsiveSize.w * 20)
                        : TextWidget(
                            color: AppColors.titleColor,
                            fontSize: AppFontSize.extralargetitle,
                            text: numOfNotes,
                            fontWeight: AppFontweight.bold.font,
                          ),
                    CustomButton(
                      centerContent: 'View All',
                      onPressed: onPressed,
                      height: ResponsiveSize.h * 28,
                      width: ResponsiveSize.w * 68,
                      fontSize: AppFontSize.extraSmalldiscription,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
