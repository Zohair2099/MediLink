import 'package:flutter/material.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder for records list
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medical Records'),
      ),
      body: const Center(
        child: Text('List of Uploaded Records Goes Here'),
      ),
    );
  }
}
