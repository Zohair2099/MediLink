import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/MedicalRecordService.dart';
import '../models/RecordModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key? key}) : super(key: key);

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _doctorController = TextEditingController();
  final _hospitalController = TextEditingController();
  final _notesController = TextEditingController();
  String? _recordType;
  File? _selectedFile;
  String? _fileName;
  bool _isLoading = false;
  double _uploadProgress = 0.0;
  String? _error;

  final List<String> _recordTypes = [
    'Prescription',
    'Lab Report',
    'Discharge Summary',
    'Imaging',
    'Other',
  ];

  Future<void> _pickFile() async {
    setState(() {
      _error = null;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _fileName = result.files.single.name;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to pick file: $e';
      });
    }
  }

  Future<void> _uploadRecord() async {
    if (!_formKey.currentState!.validate() || _selectedFile == null || _recordType == null) {
      setState(() {
        _error = 'Please fill all fields and select a file.';
      });
      return;
    }
    setState(() {
      _isLoading = true;
      _uploadProgress = 0.0;
      _error = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      // Upload file
      final service = MedicalRecordService();
      final fileUrl = await service.uploadFile(_selectedFile!);

      // Save metadata
      final record = RecordModel(
        id: '', // Firestore will generate the ID
        type: _recordType!,
        doctor: _doctorController.text.trim(),
        hospital: _hospitalController.text.trim(),
        notes: _notesController.text.trim(),
        fileUrl: fileUrl,
        timestamp: Timestamp.now(),
      );
      await service.addRecord(record);

      setState(() {
        _isLoading = false;
        _selectedFile = null;
        _fileName = null;
        _recordType = null;
        _doctorController.clear();
        _hospitalController.clear();
        _notesController.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Record uploaded successfully!')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Upload failed: $e';
      });
    }
  }

  @override
  void dispose() {
    _doctorController.dispose();
    _hospitalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medical Record'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _recordType,
                decoration: const InputDecoration(
                  labelText: 'Record Type',
                  border: OutlineInputBorder(),
                ),
                items: _recordTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _recordType = val),
                validator: (val) => val == null ? 'Select record type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _doctorController,
                decoration: const InputDecoration(
                  labelText: 'Doctor Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter doctor name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hospitalController,
                decoration: const InputDecoration(
                  labelText: 'Hospital Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Enter hospital name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _pickFile,
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Pick File (PDF/Image)'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _fileName ?? 'No file selected',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (_isLoading)
                Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 8),
                    Text('Uploading...'),
                  ],
                ),
              if (!_isLoading)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _uploadRecord,
                    child: const Text('Upload Record'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
