import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_font_sizes.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import '../../../controllers/edit note controller/edit_note_controller.dart';
import '../../../models/note_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../widgets/custom_textfield.dart';
import 'components/action_buttons.dart';
import 'components/appbar.dart';

class EditNoteScreen extends StatelessWidget {
  final NoteModel note;

  const EditNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // Initialize EditNoteController with passed note
    final editNoteController = Get.put(EditNoteController(note));
    return Obx(
      () => OverlayLoaderWithAppIcon(
        appIconSize: ResponsiveSize.h * 60,
        isLoading: editNoteController.isLoading.value,
        overlayBackgroundColor: Colors.black,
        circularProgressColor: AppColors.whiteColor,
        appIcon: Image.asset(
          AppAssets.logo2Gif,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xff252525),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(ResponsiveSize.h * 70),
            child: EditNoteAppBar(
              onSave: editNoteController.updateNote,
            ),
          ),
          bottomNavigationBar: EditNoteActionButtons(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Column(
                children: [
                  20.height,
                  // Title TextField
                  customTextfield(
                    controller: editNoteController.noteTitle,
                    hint: 'Title',
                    hintfontsize:
                        AppFontSize.noteTitleFontSize + ResponsiveSize.setSp(3),
                    fontsize: AppFontSize.noteTitleFontSize,
                    maxLines: 4,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(75),
                    ],
                  ),
                  // 20.height,
                  // 20.height,
                  // Content TextField
                  customTextfield(
                    hint: 'Type something...',
                    fontsize: AppFontSize.noteContentFontSize,
                    hintfontsize: AppFontSize.noteContentFontSize,
                    controller: editNoteController.noteContent,
                    maxLines: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
