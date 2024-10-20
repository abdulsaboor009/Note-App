import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  final String email;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  // static function to create an empty user model.
  static UserModel empty() => UserModel(
        id: '',
        name: '',
        email: '',
      );

// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Email': email,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      try {
        return UserModel(
          id: document.id,
          name: data['Name'] ?? '',
          email: data['Email'] ?? '',
        );
      } catch (e) {
        // ignore: avoid_print
        print("Error parsing UserModel data: $e");
      }
    }
    return UserModel.empty();
  }
}
