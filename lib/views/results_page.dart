import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SampleMarkdownObject {
  final String markdownText;

  SampleMarkdownObject(this.markdownText);
}

class ResultsPage extends StatelessWidget {
  final SampleMarkdownObject sampleMarkdownObject;

  ResultsPage(this.sampleMarkdownObject);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      backgroundColor: Color(0xFFFAFAF9),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: MarkdownBody(data: sampleMarkdownObject.markdownText),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle download button onPressed event
              },
              child: Text('Download'),
            ),
          ),
        ],
      ),
    );
  }
}
