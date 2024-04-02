import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'pdf_viewer_page.dart'; // Make sure this file exists in your project

class ResultsPage extends StatelessWidget {
  final PlatformFile file;

  ResultsPage({required this.file});

  Future<void> generateAndSavePdf(BuildContext context) async {
    final doc = pw.Document();

    // Enhanced content for the PDF
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(level: 0, child: pw.Text("PDF Report for: ${file.name}")),
            pw.Paragraph(
                text:
                    "This is a sample paragraph to demonstrate PDF generation. The PDF contains results for the file selected by the user. More detailed information and analysis can be included in the actual application based on the file's content."),
            // Add more content as needed
          ];
        },
      ),
    );

    try {
      final output = await getApplicationDocumentsDirectory();
      final pdfFile = File(
          "${output.path}/Results_${DateTime.now().toIso8601String()}.pdf");
      await pdfFile.writeAsBytes(await doc.save());
      print("PDF saved to: ${pdfFile.path}");

      // Navigate to the PDF viewer
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => PdfViewerPage(filePath: pdfFile.path)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to save PDF: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("File Stats: ${file.name}"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => generateAndSavePdf(context),
            child: Text("View PDF"),
          ),
        ],
      ),
    );
  }
}
