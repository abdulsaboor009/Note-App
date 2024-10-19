import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  String title;
  String content;
  bool isImportant;
  bool isTrashed;
  final DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isImportant,
    required this.isTrashed,
    required this.createdAt,
  });

  // Static function to create an empty note model.
  static NoteModel empty() => NoteModel(
        id: '',
        title: '',
        content: '',
        isImportant: false,
        isTrashed: false,
        createdAt: DateTime.now(),
      );

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Content': content,
      'IsImportant': isImportant,
      'IsTrashed': isTrashed,
      'CreatedAt': createdAt.toIso8601String(),
    };
  }

  // Factory method to create a NoteModel from a Firebase document snapshot.
  factory NoteModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      try {
        return NoteModel(
          id: document.id,
          title: data['Title'] ?? '',
          content: data['Content'] ?? '',
          isImportant: data['IsImportant'] ?? false,
          isTrashed: data['IsTrashed'] ?? false,
          createdAt: DateTime.parse(
              data['CreatedAt'] ?? DateTime.now().toIso8601String()),
        );
      } catch (e) {
        // ignore: avoid_print
        print("Error parsing NoteModel data: $e");
      }
    }
    return NoteModel.empty();
  }
}
