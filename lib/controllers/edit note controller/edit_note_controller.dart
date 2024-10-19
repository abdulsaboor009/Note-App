import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notebox/models/note_model.dart';
import 'package:notebox/controllers/note%20controller/note_controller.dart';

class EditNoteController extends GetxController {
  final NoteModel note;

  // Text controllers for editing note fields
  final noteTitle = TextEditingController();
  final noteContent = TextEditingController();
  final isLoading = false.obs;
  final isImportant = false.obs;

  // NoteController instance to call update function
  final noteController = Get.find<NoteController>();

  // Constructor: Initialize with existing note data
  EditNoteController(this.note) {
    noteTitle.text = note.title; // Initialize title from the existing note
    noteContent.text =
        note.content; // Initialize content from the existing note
  }

  // Function to update the note in Firestore
  Future<void> updateNote() async {
    isLoading.value = true; // Set loading to true to show the loader
    try {
      // Prepare updates for Firestore
      final updates = {
        'Title': noteTitle.text.trim(),
        'Content': noteContent.text.trim(),
      };

      // Call the NoteController to update the note in Firestore
      await noteController.updateNoteRecord(note.id, updates);

      // Go back to the previous screen after successful update
      Get.back();
    } catch (e) {
      // Handle error (you can show a Snackbar or Dialog for feedback)
      Get.snackbar('Error', 'Failed to update the note. Please try again.');
    } finally {
      isLoading.value = false; // Set loading to false to hide the loader
    }
  }

  // Move the note to the trash
// Toggle the note's "starred" (IsImportant) status
  Future<void> toggleStarred() async {
    isLoading.value = true;
    try {
      // Toggle the current value of 'IsImportant'
      final updates = {
        'IsImportant':
            !note.isImportant, // If it’s true, set to false, and vice versa
      };

      // Update the note in Firestore
      await noteController.updateNoteRecord(note.id, updates);

      // Update the local model's value to reflect the change
      note.isImportant = !note.isImportant;

      Get.back(); // Go back after successful update
    } catch (e) {
      Get.snackbar('Error', 'Failed to update the starred status.');
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle the note's "trashed" (IsTrashed) status
  Future<void> toggleTrash() async {
    isLoading.value = true;
    try {
      // Toggle the current value of 'IsTrashed'
      final updates = {
        'IsTrashed': !note.isTrashed,
      };

      // Update the note in Firestore
      await noteController.updateNoteRecord(note.id, updates);

      // Update the local model's value to reflect the change
      note.isTrashed = !note.isTrashed;

      Get.back(); // Go back after successful update
    } catch (e) {
      Get.snackbar('Error', 'Failed to update the trashed status.');
    } finally {
      isLoading.value = false;
    }
  }

  // Dispose controllers when not needed
  @override
  void onClose() {
    noteTitle.dispose();
    noteContent.dispose();
    super.onClose();
  }
}
