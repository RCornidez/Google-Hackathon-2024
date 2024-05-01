import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../services/socket_service.dart';
import '../services/logger_service.dart';

class ResultsPage extends StatefulWidget {
  final String markdownText;
  final String uniqueId;

  const ResultsPage(
      {super.key, required this.markdownText, required this.uniqueId});

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> {
  late SocketService socket;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initSocket();
    Log.info('Initialized the Results page.');

    socket.on('pdf_data', (data) => handlePdfData(data));
  }

  void initSocket() {
    socket = SocketService();
  }

  void requestPdf() async {
    Log.info('Requesting the environmental report.');
    if (!socket.isConnected) {
      Log.info('Socket is not connected. Attempting to connect...');
      socket.on('connect', (_) {
        setState(() => isLoading = true);
        socket.emit('request_pdf', {'session_id': widget.uniqueId});
        Log.info('Request sent after connection established.');
      });
      socket.connect();
    }
    setState(() => isLoading = true);
    socket.emit('request_pdf', {'session_id': widget.uniqueId});
  }

  void handlePdfData(dynamic data) async {
    try {
      Log.info('Opening the environmental report.');
      final base64String = data['data'];
      final fileName = data['filename'] ?? 'downloaded_report.pdf';

      final bytes = base64.decode(base64String);

      Directory? directory = await getExternalStorageDirectory();
      if (directory != null) {
        String filePath = '${directory.path}/$fileName';

        File file = File(filePath);
        await file.writeAsBytes(bytes);

        setState(() {
          isLoading = false;
        });

        if (socket.isConnected) {
          socket.disconnect();
        }

        await OpenFile.open(filePath);
      } else {
        Log.error("There was an error accessing the external storage.");
      }
    } catch (e, stack) {
      Log.error(
          "There was an error opening the environmental report.", e, stack);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      backgroundColor: const Color.fromARGB(255, 251, 248, 237),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MarkdownBody(data: widget.markdownText),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
              child: ElevatedButton(
                onPressed: isLoading ? null : requestPdf,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Open PDF Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (socket.isConnected) {
      socket.disconnect();
    }
    super.dispose();
  }
}
