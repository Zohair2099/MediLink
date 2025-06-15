import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/RecordModel.dart';

class MedicalRecordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Uploads a file to Firebase Storage and returns the file URL
  Future<String> uploadFile(File file) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final ref = _storage.ref().child('users/$uid/records/$fileName');
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // Saves record metadata to Firestore
  Future<void> addRecord(RecordModel record) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not logged in');
    final docRef = _firestore.collection('users').doc(uid).collection('records').doc();
    await docRef.set(record.toMap());
  }

  // Fetches all records for the current user, sorted by timestamp descending
  Stream<List<RecordModel>> getUserRecords() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('records')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => RecordModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Fetches a single record by ID
  Future<RecordModel?> getRecordById(String recordId) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    final doc = await _firestore.collection('users').doc(uid).collection('records').doc(recordId).get();
    if (doc.exists) {
      return RecordModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }
}
