import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'results_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isPickingFile = false; // Track if we're currently picking a file

  void _pickFiles(BuildContext context) async {
    if (_isPickingFile) return; // Exit if file picker is already active

    setState(() {
      _isPickingFile = true; // Mark as active
    });

    final result = await FilePicker.platform.pickFiles();

    // Once the FilePicker has returned or the user cancels the operation
    if (result != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultsPage(file: result.files.first)),
      );
    }

    setState(() {
      _isPickingFile = false; // Reset to allow file picking again
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Landing Page")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(child: Text("Environment Stats Here")),
          ),
          ElevatedButton(
            onPressed: _isPickingFile
                ? null
                : () =>
                    _pickFiles(context), // Disable button when picking a file
            child: Text("Upload File"),
          ),
        ],
      ),
    );
  }
}
