import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'live_scan_screen.dart';
import 'image_scan_screen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    // Step 1: Choose model
    final model = await _showModelSelectionDialog(context,false);
    if (model == null) return;

    // Step 2: Choose source (camera or gallery)
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    // Step 3: Pick image
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    // Step 4: Go to ImageScanScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageScanScreen(
          imageFile: File(pickedFile.path),
          modelName: model,
        ),
      ),
    );
  }

 /* Future<void> _startLiveScan(BuildContext context) async {
    final model = await _showModelSelectionDialog(context,true);
    if (model == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LiveScanScreen(modelName: model,),
      ),
    );
  }*/

  Future<String?> _showModelSelectionDialog(BuildContext context,bool live ) {
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Model'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text('Pest Detection'),
              onTap: () => Navigator.pop(context, 'Pest Detection'),
            ),
            ListTile(
              leading: const Icon(Icons.grass),
              title: const Text('Weed Detection'),
              onTap: () => Navigator.pop(context, 'Weed Detection'),
            ),
            Visibility(
              visible: !live,
              child: ListTile(
                leading: const Icon(Icons.local_florist),
                title: const Text('Plant Disease'),
                onTap: () => Navigator.pop(context, 'Plant Disease'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_scanner, size: 80, color: Colors.green[700]),
          const SizedBox(height: 20),
          Text(
            'Scan a Plant',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Use your camera to scan and identify a plant.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green[600]),
          ),
          const SizedBox(height: 30),
         /* ElevatedButton.icon(
            onPressed: () => _startLiveScan(context),
            icon: const Icon(Icons.camera_alt),
            label: const Text('Start Scanning'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),*/
          ElevatedButton.icon(
            onPressed: () => _pickImage(context),
            icon: const Icon(Icons.image),
            label: const Text('Upload Image'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[400],
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
