import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../data/user repository/user_repository.dart';
import '../../models/user_model.dart';
import '../../views/widgets/app_loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(
      UserCredential? userCredentials, UserModel? existingUser) async {
    try {
      // Refresh User Record
      await fetchUserRecord();

      // If no record already stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          final userName = userCredentials.user!.displayName ?? '';

          // Merge existing data if available
          final user = UserModel(
            id: userCredentials.user!.uid,
            name: userName,
            email: userCredentials.user!.email ?? '',
          );

          // Save user data
          await userRepository.saveUserDetails(user);
        }
      }
    } catch (e) {
      Loaders.warningSnackbar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your Profile',
      );
    }
  }
}
