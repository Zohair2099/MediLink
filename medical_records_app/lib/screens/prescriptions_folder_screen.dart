import 'package:flutter/material.dart';

class PrescriptionsFolderScreen extends StatelessWidget {
  const PrescriptionsFolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescriptions Folder'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'No prescriptions uploaded yet.',
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
