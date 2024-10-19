// ignore_for_file: use_rethrow_when_possible

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notebox/controllers/note%20controller/note_controller.dart';
import '../../data/authentication repository/authentication_repository.dart';
import '../../models/note_model.dart';
import '../../utils/constants/network_manager.dart';
import '../../views/widgets/app_loaders.dart';

class CreateNoteController extends GetxController {
  static CreateNoteController get instance => Get.find();

  // Variables
  final noteTitle = TextEditingController();
  final noteContent = TextEditingController();
  final isLoading = false.obs;
  final userId = AuthenticationRepository.instance.authUser?.uid;
  final noteController = Get.put(NoteController());

  // Function To Save NoteDetails
  Future<void> saveNoteDetails() async {
    // Form Validation
    if (noteTitle.text.isEmpty || noteContent.text.isEmpty) {
      isLoading.value = false;
      return;
    } else {
      try {
        // Check Internet Connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          isLoading.value = false;
          Loaders.errorSnackbar(
            title: 'Error',
            message:
                'Please make sure your device is connected to the internet!',
          );
          return;
        }

        // Start Loading
        isLoading.value = true;

        // Create a new NoteModel
        NoteModel note = NoteModel(
          id: '',
          title: noteTitle.text,
          content: noteContent.text,
          isImportant: false,
          isTrashed: false,
          createdAt: DateTime.now(),
        );

        // Save the note using your repository or directly to Firestore
        await noteController.saveNoteRecord(note);

        // Clear the form after saving
        noteTitle.clear();
        noteContent.clear();

        isLoading.value = false;
        Get.back();
      } catch (e) {
        isLoading.value = false;
        Loaders.errorSnackbar(
          title: 'Error',
          message: 'Something went wrong while saving the note.',
        );
      }
    }
  }

  Future<String> uploadImageAndGetUrl(File image) async {
    try {
      // Create a reference to the Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      // Create a unique file name
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imageRef = storageRef.child('note_images/$fileName');

      // Upload the image
      await imageRef.putFile(image);

      // Get the download URL
      final imageUrl = await imageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading image: $e');
      throw e;
    }
  }
}
