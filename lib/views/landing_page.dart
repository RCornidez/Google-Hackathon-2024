import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math';
import 'results_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isPickingFile = false; // Track if we're currently picking a file

  List<String> environmentalFacts = [
    "Fact 1",
    "Fact 2",
    "Fact 3",
  ];

  List<String> funnyPuns = [
    "Pun 1",
    "Pun 2",
    "Pun 3",
  ];

  int environmentalFactIndex = 0;
  int funnyPunIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start the periodic timer to rotate facts
    Stream.periodic(Duration(seconds: 5)).listen((_) {
      setState(() {
        environmentalFactIndex =
            (environmentalFactIndex + 1) % environmentalFacts.length;
      });
    });

    // Select a random funny pun initially
    funnyPunIndex = Random().nextInt(funnyPuns.length);
  }

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

  void _showHowItWorksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("How it works"),
          content: Text(
              "Your explanation about how the application works goes here."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Landing Page")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      environmentalFacts[environmentalFactIndex],
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      funnyPuns[funnyPunIndex],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _showHowItWorksDialog(context);
                      },
                      child: Text(
                        "How it works",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          _isPickingFile ? null : () => _pickFiles(context),
                      child: _isPickingFile
                          ? CircularProgressIndicator()
                          : Text("Upload File"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
