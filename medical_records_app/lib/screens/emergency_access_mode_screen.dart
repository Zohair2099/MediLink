import 'package:flutter/material.dart';

class EmergencyAccessModeScreen extends StatelessWidget {
  const EmergencyAccessModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Access Mode'),
      ),
      body: const Center(
        child: Text('Welcome to Emergency Access Mode!'),
      ),
    );
  }
}
