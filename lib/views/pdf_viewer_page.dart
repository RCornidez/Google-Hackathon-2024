import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatelessWidget {
  final String filePath;

  const PdfViewerPage({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View PDF")),
      body: PDFView(
        filePath: filePath,
        autoSpacing: false,
        swipeHorizontal: true,
        pageSnap: true,
        pageFling: true,
      ),
    );
  }
}
