import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nanoid/nanoid.dart';
import 'loading_page.dart';
import '../services/logger_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  bool _isPickingFile = false;
  int funnyPunIndex = 0;
  List<String> funnyPuns = [
    "Don't leaf us hanging! Upload your report and branch out.",
    "Let's turn over a new leaf! Upload your report and sow the seeds of change.",
    "Going green is a bright idea! Upload your report and help us grow.",
    "Reduce, reuse, recycle... and upload! Let's make a difference together.",
    "Eco-warriors unite! Upload your report and be part of the green team.",
    "Join the compost crew! Upload your report and watch our efforts bloom.",
    "Time to make waves! Upload your report and dive into environmental action.",
    "Be the change you wish to sea! Upload your report and ride the wave of sustainability.",
    "Let's clean up our act! Upload your report and help us keep the planet pristine.",
    "It's not easy being green, but it's worth it! Upload your report and join the eco-friendly revolution.",
  ];

  @override
  void initState() {
    super.initState();
    funnyPunIndex = Random().nextInt(funnyPuns.length);
    Log.info('Initialized the Landing page.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFe0f2fe),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    'assets/logo.png',
                    alignment: Alignment.topCenter,
                    height: 250.0,
                    fit: BoxFit.contain,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          funnyPuns[funnyPunIndex],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontFamily: 'bodyMedium',
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed:
                              _isPickingFile ? null : () => _pickFiles(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFede9fe), // Background color
                            foregroundColor:
                                const Color(0xFF581c87), // Font color
                          ),
                          child: _isPickingFile
                              ? const CircularProgressIndicator()
                              : const Text("Upload File"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickFiles(BuildContext context) async {
    if (_isPickingFile) return;

    setState(() {
      _isPickingFile = true;
    });

    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles();
    } catch (e, stack) {
      Log.error("There was an error when picking a file.", e, stack);
    }

    if (result != null && result.files.single.path != null) {
      Log.info("A file was selected for uploading");
      final pickedFile = File(result.files.single.path!);

      try {
        final pdfBytes = await pickedFile.readAsBytes();
        final uniqueId = nanoid(5);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                LoadingPage(pdfBytes: pdfBytes, uniqueId: uniqueId),
          ),
        );
      } catch (e) {
        Log.error("Failed to read file", e);
      }
    } else {
      Log.error("A file was not selected.");
    }

    setState(() {
      _isPickingFile = false;
    });
  }
}
