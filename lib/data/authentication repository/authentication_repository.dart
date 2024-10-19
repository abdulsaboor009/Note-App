import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notebox/views/screens/authentication/google_authentication.dart';
import '../../views/screens/navigation drawer/navigation_drawer.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  // final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  // final _firestore = FirebaseFirestore.instance;
  // final userController = Get.put(UserController());

  // Get Authenticated user data.
  User? get authUser => _auth.currentUser;

  // Called from main.dart on app lounch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    // Delay to show splash screen for 3 seconds
    await Future.delayed(const Duration(milliseconds: 3000));
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => const NavigationDrawerWidget());
    } else {
      Get.offAll(() => const GoogleAuthenticationScreen());
      // deviceStorage.writeIfNull('IsFirstTime', true);
      // if (deviceStorage.read('IsFirstTime') != true) {
      //   Get.offAll(const LoginScreen());
      // } else {
      //   Get.offAll(const OnboardingScreen());
      // }
    }
  }

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth detail from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception('FirebaseAuthException: ${e.message}');
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /// [LogoutUser] Valid for any authentication.
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const GoogleAuthenticationScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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
