import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user_model.dart';
import '../authentication repository/authentication_repository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data to Firestore.
  Future<void> saveUserDetails(UserModel user) async {
    try {
      // Reference to the UserDetails subcollection
      final userDetailsRef =
          _db.collection("Users").doc(user.id).collection("UserDetails").doc();

      // Save the user details with the generated ID
      await userDetailsRef.set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // Function to fetch user details based on user id.
  Future<UserModel> fetchUserDetails() async {
    try {
      // Access the UserDetails subcollection within the user's document
      final querySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('UserDetails')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document in UserDetails
        final documentSnapshot = querySnapshot.docs.first;

        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  // update any field in specific User Collection
  Future<void> updateSingleFieldName(Map<String, dynamic> json) async {
    try {
      // Get the UserDetails document ID
      final querySnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection('UserDetails')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document in UserDetails
        final documentId = querySnapshot.docs.first.id;

        // Update the specific field in the UserDetails document
        await _db
            .collection("Users")
            .doc(AuthenticationRepository.instance.authUser?.uid)
            .collection('UserDetails')
            .doc(documentId)
            .update(json);
      } else {
        throw 'No UserDetails document found.';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

// Upload Any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }
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
