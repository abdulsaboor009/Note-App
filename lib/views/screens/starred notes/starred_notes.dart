import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/widgets/date_time_format_extention.dart';
import 'package:notebox/views/widgets/sizedbox_extention.dart';
import '../../../controllers/note controller/note_controller.dart';
import '../../widgets/appbar.dart';
import '../../widgets/notes_card.dart';
import '../edit note/edit_note.dart';
import '../empty notes screen/empty_notes_screen.dart';

class StarredNotesScreen extends StatelessWidget {
  const StarredNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(ResponsiveSize.h * 105),
            child: AppBarWidget(
              title: 'Starred Notes',
            )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: Column(
              children: [
                10.height,
                // Obx(() =>
                //   Text()
                // ),
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
                  } else if (noteController.starredNotes.isEmpty) {
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
                      itemCount: noteController.starredNotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        final starredNote = noteController.starredNotes[index];
                        return NotesCard(
                          onPressed: () {
                            Get.to(() => EditNoteScreen(note: starredNote));
                          },
                          title: starredNote.title,
                          content: starredNote.content,
                          time: starredNote.createdAt.toFormattedString(),
                          isLoading: false, // Format time as needed
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
