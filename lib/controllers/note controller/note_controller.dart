import 'package:get/get.dart';
import '../../data/note repository/note_repository.dart';
import '../../models/note_model.dart';
import '../../views/widgets/app_loaders.dart';

class NoteController extends GetxController {
  static NoteController get instance => Get.find();

  // Variables
  RxList<NoteModel> notes = <NoteModel>[].obs;
  RxList<NoteModel> recentNotes = <NoteModel>[].obs;
  RxList<NoteModel> trashNotes = <NoteModel>[].obs;
  RxList<NoteModel> starredNotes = <NoteModel>[].obs;
  final isLoading = false.obs;
  final noteRepository = Get.put(NoteRepository());
  RxInt totalNotesCount = 0.obs;
  RxInt starredNotesCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNotes();
  }

  // Function to Fetch All Notes
  Future<void> fetchAllNotes() async {
    try {
      isLoading.value = true;

      // Fetch all notes
      final allNotes = await noteRepository.fetchAllNotes();

      // Separate non-trash, trash, and starred notes
      final nonTrashNotes = allNotes.where((note) => !note.isTrashed).toList();
      final trashedNotes = allNotes.where((note) => note.isTrashed).toList();
      final importantNotes =
          nonTrashNotes.where((note) => note.isImportant).toList();

      // Assign notes, trash notes, and starred notes to their respective lists
      notes.assignAll(nonTrashNotes);
      trashNotes.assignAll(trashedNotes);
      starredNotes.assignAll(importantNotes);

      // Update total notes and starred notes counts
      totalNotesCount.value = nonTrashNotes.length;
      starredNotesCount.value =
          nonTrashNotes.where((note) => note.isImportant).length;

      // Get the 6 most recent notes
      recentNotes.assignAll(nonTrashNotes.take(4).toList());
    } catch (e) {
      notes.clear();
      trashNotes.clear();
      starredNotes.clear();
      totalNotesCount.value = 0;
      starredNotesCount.value = 0;
      Loaders.errorSnackbar(
        title: 'Error',
        message: e,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Save a new note
  Future<void> saveNoteRecord(NoteModel note) async {
    try {
      await noteRepository.saveNoteDetails(note);
      fetchAllNotes(); // Refresh notes after saving
    } catch (e) {
      Loaders.errorSnackbar(
        title: 'Error',
        message: e,
      );
    }
  }

  // Update an existing note
  Future<void> updateNoteRecord(
      String noteId, Map<String, dynamic> updates) async {
    try {
      await noteRepository.updateNote(noteId, updates);
      fetchAllNotes(); // Refresh notes after updating
    } catch (e) {
      Loaders.errorSnackbar(
        title: 'Error',
        message: e,
      );
    }
  }

  // Function to delete all trash notes
  Future<void> clearAllTrashNotes() async {
    isLoading.value = true;
    try {
      isLoading.value = true;
      // Loop through the trash notes and delete each one
      for (var note in trashNotes) {
        await noteRepository
            .deleteNote(note.id); // Delete the note from Firestore
      }

      // Refresh the notes list after clearing the trash
      fetchAllNotes();

      Get.back();
    } catch (e) {
      Loaders.errorSnackbar(
        title: 'Error',
        message: e,
      );
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
