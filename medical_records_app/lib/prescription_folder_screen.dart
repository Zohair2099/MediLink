import 'package:flutter/material.dart';

class PrescriptionFolderScreen extends StatelessWidget {
  const PrescriptionFolderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Folder'),
      ),
      body: const Center(
        child: Text('This is the Prescription folder. Here you can view and manage prescriptions.'),
      ),
    );
  }
}
