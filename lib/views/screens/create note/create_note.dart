import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_font_sizes.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import '../../../controllers/create note controller/create_note_controller.dart';
import '../../../utils/constants/app_colors.dart';
import '../../widgets/custom_textfield.dart';
import 'components/appbar.dart';

class CreateNoteSCreen extends StatelessWidget {
  const CreateNoteSCreen({super.key});
  @override
  Widget build(BuildContext context) {
    final createNoteController = Get.put(CreateNoteController());
    return Obx(
      () => OverlayLoaderWithAppIcon(
        appIconSize: ResponsiveSize.h * 60,
        isLoading: createNoteController.isLoading.value,
        overlayBackgroundColor: Colors.black,
        circularProgressColor: AppColors.whiteColor,
        appIcon: Image.asset(
          AppAssets.logo2Gif,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xff252525),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(ResponsiveSize.h * 70),
            child: const CreateNoteAppBar(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Column(
                children: [
                  20.height,
                  customTextfield(
                    controller: createNoteController.noteTitle,
                    hint: 'Title',
                    hintfontsize:
                        AppFontSize.noteTitleFontSize + ResponsiveSize.setSp(3),
                    fontsize: AppFontSize.noteTitleFontSize,
                    maxLines: 4,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(75),
                    ],
                  ),
                  // Obx(() {
                  //   return StaggeredGrid.count(
                  //     crossAxisCount: 4,
                  //     mainAxisSpacing: ResponsiveSize.h * 10,
                  //     crossAxisSpacing: ResponsiveSize.w * 10,
                  //     children: createNoteController.images
                  //         .asMap()
                  //         .entries
                  //         .map((entry) {
                  //       int index = entry.key;
                  //       File imageFile = entry.value;
                  //       if (index == 0) {
                  //         return StaggeredGridTile.count(
                  //           crossAxisCellCount: 4,
                  //           mainAxisCellCount: 2,
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(20),
                  //             child: GestureDetector(
                  //               onDoubleTap: () {
                  //                 showDeleteViewImageDialog(
                  //                     context, index, imageFile);
                  //               },
                  //               onLongPress: () {
                  //                 showDeleteViewImageDialog(
                  //                     context, index, imageFile);
                  //               },
                  //               child: Image.file(
                  //                 imageFile,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       } else {
                  //         return StaggeredGridTile.count(
                  //           crossAxisCellCount: 2,
                  //           mainAxisCellCount: 2,
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(20),
                  //             child: GestureDetector(
                  //               onDoubleTap: () {
                  //                 showDeleteViewImageDialog(
                  //                     context, index, imageFile);
                  //               },
                  //               onLongPress: () {
                  //                 showDeleteViewImageDialog(
                  //                     context, index, imageFile);
                  //               },
                  //               child: Image.file(
                  //                 imageFile,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //     }).toList(),
                  //   );
                  // }),
                  customTextfield(
                      hint: ' Type something...',
                      fontsize: AppFontSize.noteContentFontSize,
                      hintfontsize: AppFontSize.noteContentFontSize,
                      controller: createNoteController.noteContent),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
