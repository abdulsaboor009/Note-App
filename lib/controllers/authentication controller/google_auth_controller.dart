import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notebox/views/screens/navigation%20drawer/navigation_drawer.dart';
import '../../data/authentication repository/authentication_repository.dart';
import '../../data/user repository/user_repository.dart';
import '../../models/user_model.dart';
import '../../utils/constants/network_manager.dart';
import '../../views/widgets/app_loaders.dart';
import '../user controller/user_controller.dart';

class GoogleAuthenticationController extends GetxController {
  static GoogleAuthenticationController get instance => Get.find();

  // Variables
  final showUserNameField = false.obs;
  final isLoading = false.obs;
  final userController = Get.put(UserController());
  final userName = TextEditingController();
  GlobalKey<FormState> userNameFormKey = GlobalKey<FormState>();
  final userRepository = Get.put(UserRepository());

  // GoogleAuthentication Method
  Future<void> googleAuthentication() async {
    try {
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        Loaders.errorSnackbar(
          title: 'Error',
          message: 'Please make sure your device is connected with internet!',
        );
        return;
      }

      // Start Loading
      isLoading.value = true;

      // Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();
      if (userCredentials == null) {
        throw Exception('Failed to sign in with Google');
      }

      // Check if email exists in Firestore
      final userEmail = userCredentials.user?.email;
      if (userEmail == null) {
        throw Exception('No email associated with this Google account');
      }

      final userExists = await _checkIfEmailExists(userEmail);

      // Fetch existing user data if it exists
      UserModel? existingUser;
      if (userExists) {
        existingUser = await _fetchUserByEmail(userEmail);
      }

      // Save User Record (merge existing data if necessary)
      await userController.saveUserRecord(userCredentials, existingUser);

      // Stop Loading
      isLoading.value = false;

      // Show the UserName Field
      showUserNameField.value = true;

      // // Move to HomeScreen
      // Get.offAll(() => const NavigationDrawerWidget());

      // // Initialize user data in the controller
      // await UpdateUserProfileController.instance.initializeNames();
    } catch (e) {
      isLoading.value = false;
      Loaders.errorSnackbar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
    // showUserNameField.value = true;
  }

  // // Helper function to check if email exists in Firestore
  // Future<bool> _checkIfEmailExists(String email) async {
  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .where('Email', isEqualTo: email)
  //       .limit(1)
  //       .get();

  //   return querySnapshot.docs.isNotEmpty;
  // }

  Future<bool> _checkIfEmailExists(String email) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    // Iterate through each user's UserDetails subcollection to check for the email
    for (var userDoc in querySnapshot.docs) {
      final userDetailsSnapshot = await userDoc.reference
          .collection('UserDetails')
          .where('Email', isEqualTo: email)
          .limit(1)
          .get();

      if (userDetailsSnapshot.docs.isNotEmpty) {
        return true;
      }
    }

    return false;
  }

// // Helper function to fetch user by email
//   Future<UserModel?> _fetchUserByEmail(String email) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('Users')
//         .where('Email', isEqualTo: email)
//         .limit(1)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       return UserModel.fromSnapshot(querySnapshot.docs.first);
//     }
//     return null;
//   }
  Future<UserModel?> _fetchUserByEmail(String email) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    // Iterate through each user's UserDetails subcollection to find the user by email
    for (var userDoc in querySnapshot.docs) {
      final userDetailsSnapshot = await userDoc.reference
          .collection('UserDetails')
          .where('Email', isEqualTo: email)
          .limit(1)
          .get();

      if (userDetailsSnapshot.docs.isNotEmpty) {
        // Assuming the UserModel is built based on UserDetails
        return UserModel.fromSnapshot(userDetailsSnapshot.docs.first);
      }
    }

    return null;
  }

  // Function to get User name
  Future<void> getUserName() async {
    try {
      // Form Validation
      if (!userNameFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        Loaders.errorSnackbar(
          title: 'Error',
          message: 'Please make sure your device is connected with internet!',
        );
        return;
      }

      // Start Loading
      isLoading.value = true;

      // Update user record in the Firestore Database
      Map<String, dynamic> updatedUserProfile = {
        'Name': userName.text.trim(),
      };
      await userRepository.updateSingleFieldName(updatedUserProfile);

      // Update the Rx User value
      userController.user.value.name = userName.text.trim();

      // Refresh the user to notify the listeners
      userController.user.refresh();

      // Stop Loader
      isLoading.value = false;

      // Move to HomeScreen
      Get.offAll(() => const NavigationDrawerWidget());

      // Remove the user name field
      showUserNameField.value = false;
    } catch (e) {
      // Stop Loader
      isLoading.value = false;
      Loaders.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
}
