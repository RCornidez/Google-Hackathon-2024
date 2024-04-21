import 'package:flutter/material.dart';
import 'results_page.dart';

// Modify the LoadingPage to pass the simulated object to the ResultsPage
class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to the ResultsPage after a delay
    Future.delayed(Duration(seconds: 3), () {
      // Define the multiline markdown text as a regular string with line breaks
      String markdownText = """
# trees_bees_seas

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
""";

      // Pass the simulated object to the ResultsPage with proper markdown text formatting
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultsPage(SampleMarkdownObject(markdownText))),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E8FF), // Background color of the scaffold
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 5,
                shadowColor: Color(0xFF292524), // Border shadow color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
                color: Color(0xFFFAFAF9), // Card background color
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Counting fish population',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'bodyMedium',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
