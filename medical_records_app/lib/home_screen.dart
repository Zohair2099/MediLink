import 'package:flutter/material.dart';
import 'medical_records_system_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!'),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.folder_special),
              label: const Text('Medical Records System'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MedicalRecordsSystemScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
