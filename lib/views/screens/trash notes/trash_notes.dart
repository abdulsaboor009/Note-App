import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/date_time_format_extention.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../../controllers/edit note controller/edit_note_controller.dart';
import '../../../controllers/note controller/note_controller.dart';
import '../../../utils/constants/app_images.dart';
import '../../widgets/action_diaglog.dart';
import '../../widgets/appbar.dart';
import '../../widgets/notes_card.dart';
import '../empty notes screen/empty_notes_screen.dart';

class TrashNotesScreen extends StatelessWidget {
  const TrashNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(ResponsiveSize.h * 105),
            child: AppBarWidget(
              title: 'Trash Notes',
              showClearTrashButton:
                  noteController.trashNotes.isEmpty ? false : true,
            )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: Column(
              children: [
                10.height,
                Obx(() {
                  if (noteController.isLoading.value) {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ResponsiveSize.w * 12,
                        mainAxisSpacing: ResponsiveSize.h * 12,
                        mainAxisExtent: ResponsiveSize.h * 180,
                      ),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return NotesCard(
                          onPressed: () {},
                          title: '',
                          content: '',
                          time: '',
                          isLoading: true, // Format time as needed
                        );
                      },
                    );
                  } else if (noteController.trashNotes.isEmpty) {
                    return const EmptyNoteScreen();
                  } else {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ResponsiveSize.w * 12,
                        mainAxisSpacing: ResponsiveSize.h * 12,
                        mainAxisExtent: ResponsiveSize.h * 180,
                      ),
                      itemCount: noteController.trashNotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final trashNote = noteController.trashNotes[index];
                        return NotesCard(
                          onPressed: () {
                            actionDiaglog(
                              context,
                              onSubmit: () async {
                                Get.back();
                                // Call the restoreNote function from EditNoteController
                                final editNoteController =
                                    EditNoteController(trashNote);
                                await editNoteController.toggleTrash();
                              },
                              subTitle: "Are you sure? You want to Restore",
                              title: "Restore",
                              diaglogImage: AppAssets.delete,
                            );
                          },
                          title: trashNote.title,
                          content: trashNote.content,
                          time: trashNote.createdAt.toFormattedString(),
                          isLoading: false,
                          isImportant: trashNote.isImportant,
                        );
                      },
                    );
                  }
                }),
                25.height,
              ],
            ),
          ),
        ));
  }
}
