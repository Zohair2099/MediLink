import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

class ImageUploadService {
  static Future<void> uploadMedicalImage({
    required File imageFile,
    required String type, // 'reports' or 'prescriptions'
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final fileName = basename(imageFile.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child('users/$uid/$type/$fileName');

    await ref.putFile(imageFile);
    final imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection(type)
        .add({
          'imageUrl': imageUrl,
          'uploadedAt': Timestamp.now(),
        });
  }
}
