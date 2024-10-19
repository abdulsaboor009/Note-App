import 'package:flutter/material.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_font_sizes.dart';
import '../../../utils/constants/app_font_weights.dart';
import '../../../utils/constants/app_images.dart';
import '../../widgets/custom_text.dart';

class EmptyNoteScreen extends StatelessWidget {
  const EmptyNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Center(
          child: Image.asset(
            AppAssets.notes,
            height: ResponsiveSize.h * 150,
          ),
        ),
        15.height,
        Center(
          child: TextWidget(
            color: AppColors.titleColor,
            fontSize: AppFontSize.screenTitle,
            fontWeight: AppFontweight.bold.font,
            text: 'Note Not Found!',
          ),
        ),
      ],
    );
  }
}
