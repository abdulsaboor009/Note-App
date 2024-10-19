import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../models/note_model.dart';
import '../authentication repository/authentication_repository.dart';

class NoteRepository extends GetxController {
  static NoteRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// **Creating And Saving Note**
  Future<void> saveNoteDetails(NoteModel note) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      if (note.id.isNotEmpty) {
        // Note ID is not empty, meaning the note already exists, so update it
        await _db
            .collection("Users")
            .doc(userId)
            .collection("UserNotes")
            .doc(note.id)
            .update(note.toJson());
      } else {
        // Note ID is empty, meaning it's a new note, so create it
        await _db
            .collection("Users")
            .doc(userId)
            .collection("UserNotes")
            .add(note.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.message ?? 'FirebaseException');
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'PlatformException');
    } catch (e) {
      throw 'Something went wrong while saving the note: $e';
    }
  }

  // /// **Create a New Note**
  // Future<void> createNote(NoteModel note) async {
  //   try {
  //     final userId = AuthenticationRepository.instance.authUser?.uid;
  //     if (userId == null) throw 'User not authenticated';

  //     await _db
  //         .collection("Users")
  //         .doc(userId)
  //         .collection("UserNotes")
  //         .add(note.toJson());
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.message ?? 'FirebaseException');
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.message ?? 'PlatformException');
  //   } catch (e) {
  //     throw 'Something went wrong while creating the note: $e';
  //   }
  // }

  /// **Fetch All Notes**
  Future<List<NoteModel>> fetchAllNotes() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      final querySnapshot = await _db
          .collection("Users")
          .doc(userId)
          .collection("UserNotes")
          .orderBy('CreatedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => NoteModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.message ?? 'FirebaseException');
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'PlatformException');
    } catch (e) {
      throw 'Something went wrong while fetching notes: $e';
    }
  }

  /// **Fetch Important Notes**
  Future<List<NoteModel>> fetchImportantNotes() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      final querySnapshot = await _db
          .collection("Users")
          .doc(userId)
          .collection("UserNotes")
          .where('isImportant', isEqualTo: true)
          .orderBy('CreatedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => NoteModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.message ?? 'FirebaseException');
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'PlatformException');
    } catch (e) {
      throw 'Something went wrong while fetching important notes: $e';
    }
  }

  /// **Update a Note**
  Future<void> updateNote(String noteId, Map<String, dynamic> data) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      await _db
          .collection("Users")
          .doc(userId)
          .collection("UserNotes")
          .doc(noteId)
          .update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.message ?? 'FirebaseException');
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'PlatformException');
    } catch (e) {
      throw 'Something went wrong while updating the note: $e';
    }
  }

  /// **Delete a Note**
  Future<void> deleteNote(String noteId) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      await _db
          .collection("Users")
          .doc(userId)
          .collection("UserNotes")
          .doc(noteId)
          .delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.message ?? 'FirebaseException');
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'PlatformException');
    } catch (e) {
      throw 'Something went wrong while deleting the note: $e';
    }
  }

  // Delete image from Firebase Storage
  Future<void> deleteImageFromStorage(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl); // Get a reference to the image
      await ref.delete(); // Delete the image
    } catch (e) {
      throw Exception('Error deleting image from Firebase Storage');
    }
  }

  /// **Toggle Important Status**
  Future<void> toggleImportantStatus(String noteId, bool isImportant) async {
    await updateNote(noteId, {'isImportant': !isImportant});
  }

  /// **Move Note to Trash**
  Future<void> moveNoteToTrash(String noteId) async {
    await updateNote(noteId, {'isTrashed': true});
  }

  /// **Restore Note from Trash**
  Future<void> restoreNoteFromTrash(String noteId) async {
    await updateNote(noteId, {'isTrashed': false});
  }

  /// **Fetch Trashed Notes**
  Future<List<NoteModel>> fetchTrashedNotes() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      final querySnapshot = await _db
          .collection("Users")
          .doc(userId)
          .collection("UserNotes")
          .where('IsTrashed', isEqualTo: true)
          .orderBy('CreatedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => NoteModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.message ?? 'FirebaseException');
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'PlatformException');
    } catch (e) {
      throw 'Something went wrong while fetching trashed notes: $e';
    }
  }

  /// **Empty Trash**
  Future<void> emptyTrash() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      final trashedNotes = await _db
          .collection("Users")
          .doc(userId)
          .collection("UserNotes")
          .where('isTrashed', isEqualTo: true)
          .get();

      for (var doc in trashedNotes.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.message ?? 'FirebaseException');
    } on PlatformException catch (e) {
      throw TPlatformException(e.message ?? 'PlatformException');
    } catch (e) {
      throw 'Something went wrong while emptying trash: $e';
    }
  }

  /// **Upload Image and Get URL**
  // Future<String> uploadImage(XFile image) async {
  //   try {
  //     final userId = AuthenticationRepository.instance.authUser?.uid;
  //     if (userId == null) throw 'User not authenticated';

  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('user_notes_images/$userId/${image.name}');
  //     await storageRef.putFile(File(image.path));
  //     final imageUrl = await storageRef.getDownloadURL();
  //     return imageUrl;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.message ?? 'FirebaseException');
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.message ?? 'PlatformException');
  //   } catch (e) {
  //     throw 'Something went wrong while uploading the image: $e';
  //   }
  // }
}

class TFirebaseAuthException implements Exception {
  final String message;

  TFirebaseAuthException(this.message);
}

class TFirebaseException implements Exception {
  final String message;

  TFirebaseException(this.message);
}

class TFormatException implements Exception {
  final String message;

  TFormatException([this.message = 'Invalid format']);

  @override
  String toString() => message;
}

class TPlatformException implements Exception {
  final String message;

  TPlatformException(this.message);
}
