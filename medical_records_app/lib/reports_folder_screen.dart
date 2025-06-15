import 'package:flutter/material.dart';

class ReportsFolderScreen extends StatelessWidget {
  const ReportsFolderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports Folder'),
      ),
      body: const Center(
        child: Text('This is the Reports folder. Here you can view and manage medical reports.'),
      ),
    );
  }
}
