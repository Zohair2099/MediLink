import 'package:flutter/material.dart';

class RecordDetailsScreen extends StatelessWidget {
  final String recordId;

  const RecordDetailsScreen({Key? key, required this.recordId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder for record details and file preview/download
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
      ),
      body: const Center(
        child: Text('Record Details and File Preview Goes Here'),
      ),
    );
  }
}
