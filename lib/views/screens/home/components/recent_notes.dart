import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/controllers/note%20controller/note_controller.dart';
import 'package:notebox/utils/constants/responsive_sizes.dart';
import 'package:notebox/views/screens/edit%20note/edit_note.dart';
import 'package:notebox/views/widgets/date_time_format_extention.dart';
import 'package:notebox/views/widgets/notes_card.dart';
import '../../empty notes screen/empty_notes_screen.dart';

class HomeRecentNotes extends StatelessWidget {
  const HomeRecentNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    return Obx(() {
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
              isLoading: true,
            );
          },
        );
      } else if (noteController.recentNotes.isEmpty) {
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
          itemCount: noteController.recentNotes.length,
          itemBuilder: (BuildContext context, int index) {
            final note = noteController.recentNotes[index];
            return NotesCard(
              onPressed: () {
                final note = noteController.recentNotes[index];
                Get.to(() => EditNoteScreen(note: note));
              },
              title: note.title,
              content: note.content,
              time: note.createdAt.toFormattedString(),
              isLoading: false,
              isImportant: note.isImportant,
            );
          },
        );
      }
    });
  }
}
