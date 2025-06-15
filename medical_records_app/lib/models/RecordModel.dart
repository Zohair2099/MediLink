import 'package:cloud_firestore/cloud_firestore.dart';

class RecordModel {
  final String id;
  final String type;
  final String doctor;
  final String hospital;
  final String notes;
  final String fileUrl;
  final Timestamp timestamp;

  RecordModel({
    required this.id,
    required this.type,
    required this.doctor,
    required this.hospital,
    required this.notes,
    required this.fileUrl,
    required this.timestamp,
  });

  factory RecordModel.fromMap(Map<String, dynamic> map, String id) {
    return RecordModel(
      id: id,
      type: map['type'] ?? '',
      doctor: map['doctor'] ?? '',
      hospital: map['hospital'] ?? '',
      notes: map['notes'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'doctor': doctor,
      'hospital': hospital,
      'notes': notes,
      'fileUrl': fileUrl,
      'timestamp': timestamp,
    };
  }
}
