import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/image_upload_service.dart';

class MedicalRecordsSystemScreen extends StatelessWidget {
  const MedicalRecordsSystemScreen({super.key});

  void _openCamera(BuildContext context, String folderType) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final File imageFile = File(image.path);

      try {
        await ImageUploadService.uploadMedicalImage(
          imageFile: imageFile,
          type: folderType,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$folderType image uploaded successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
        );
      }
    }
  }

  void _showCameraTargetDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Upload Image To",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text("Reports Folder"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _openCamera(context, 'reports');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text("Prescriptions Folder"),
                  onTap: () {
                    Navigator.pop(ctx);
                    _openCamera(context, 'prescriptions');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double boxSize = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical Records System',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose a Folder",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSquareFolderTile(
                  context,
                  icon: Icons.description_rounded,
                  title: 'Reports',
                  subtitle: 'Medical Reports',
                  onTap: () => Navigator.pushNamed(context, '/reports'),
                  size: boxSize,
                ),
                _buildSquareFolderTile(
                  context,
                  icon: Icons.receipt_long,
                  title: 'Prescriptions',
                  subtitle: 'Medicines List',
                  onTap: () => Navigator.pushNamed(context, '/prescriptions'),
                  size: boxSize,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCameraTargetDialog(context),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.camera_alt, size: 28),
      ),
    );
  }

  Widget _buildSquareFolderTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required double size,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.teal),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
