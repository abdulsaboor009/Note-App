import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/app_colors.dart';
import 'package:notebox/utils/constants/app_images.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/action_diaglog.dart';
import '../../../../controllers/edit note controller/edit_note_controller.dart';

// ignore: must_be_immutable
class EditNoteActionButtons extends StatelessWidget {
  final EditNoteController editNoteController = Get.find<EditNoteController>();

  EditNoteActionButtons({super.key});

  List<String> actionButtons = [
    AppAssets.favouriteOutline,
    AppAssets.delete,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ResponsiveSize.h * 60,
        width: double.infinity,
        color: AppColors.secondaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () async {
                  await editNoteController.toggleStarred();
                },
                icon: Image.asset(
                  editNoteController.note.isImportant
                      ? AppAssets.favouriteFilled
                      : AppAssets.favouriteOutline,
                  color: AppColors.whiteColor,
                  height: ResponsiveSize.h * 28,
                ),
                iconSize: ResponsiveSize.h * 28,
              ),
              IconButton(
                onPressed: () async {
                  actionDiaglog(
                    context,
                    onSubmit: () async {
                      Get.back();
                      await editNoteController.toggleTrash();
                    },
                    subTitle: "Are you sure? You want to delete",
                    title: "Delete",
                    diaglogImage: AppAssets.delete,
                  );
                },
                icon: Image.asset(
                  AppAssets.delete,
                  color: AppColors.whiteColor,
                  height: ResponsiveSize.h * 28,
                ),
                iconSize: ResponsiveSize.h * 28,
              ),
            ],
          ),
        ));
  }
}
