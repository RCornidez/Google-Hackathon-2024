import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'results_page.dart';
import '../services/socket_service.dart';
import '../services/logger_service.dart';

class LoadingPage extends StatefulWidget {
  final List<int> pdfBytes;
  final String uniqueId;

  const LoadingPage(
      {super.key, required this.pdfBytes, required this.uniqueId});

  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  late SocketService socket;
  bool markdownRequested = false;
  String? markdownText;
  String currentStatus = 'Connecting to server...';

  final Map<String, String> eventStatusMessages = {
    'review_file': 'Reviewing your file.',
    'generating_report': 'Generating your environmental report.',
    'report_finished': 'Report ready. Opening the results.',
  };

  @override
  void initState() {
    super.initState();
    Log.info('Initialized the Loading page.');
    _connectToSocket();
  }

  void _connectToSocket() {
    socket = SocketService();

    socket.on('report_finished', _handleReportFinished);

    socket.on('markdown_data', (data) => _handleMarkdownData(data));

    eventStatusMessages.forEach((event, message) {
      socket.on(event, (data) => _updateStatus(message));
    });

    _uploadPdf();
  }

  void _updateStatus(String newStatus) {
    setState(() {
      currentStatus = newStatus;
    });
  }

  void _handleReportFinished(data) {
    if (!markdownRequested) {
      socket.emit('request_markdown', {'session_id': widget.uniqueId});
      setState(() {
        markdownRequested = true;
      });
    }
  }

  _handleMarkdownData(data) {
    try {
      if (data != null) {
        markdownText = data['data']['markdown'];
        if (markdownText != null) {
          _navigateToResultsPage();
        } else {
          Log.info(
              'Markdown text is null within the data object recieved from the API server.');
        }
      } else {
        Log.info('Recieved a null markdown data object form the API server.');
      }
    } catch (e, stack) {
      Log.error(
          "There was an error processing the Markdown from the API server.",
          e,
          stack);
    }
  }

  void _uploadPdf() {
    try {
      if (socket.isConnected == false) {
        Log.info('Socket is not connected. Attempting to connect...');
        socket.on('connect', (_) {
          socket.emit('upload_pdf', {
            'session_id': widget.uniqueId,
            'pdf_data': widget.pdfBytes,
          });
          Log.info('Request sent after connection established.');
        });
        socket.connect();
      }
      socket.emit('upload_pdf', {
        'session_id': widget.uniqueId,
        'pdf_data': widget.pdfBytes,
      });
      Log.info('Sent Client PDF file to API server.');
    } catch (e) {
      Log.error(
          'There was an error sending the PDF file to the API server.', e);
    }
  }

  void _navigateToResultsPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(
          markdownText: markdownText!,
          uniqueId: widget.uniqueId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Lottie.asset(
                'assets/loading.json',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 5,
              shadowColor: Color(0xFF292524),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Color(0xFFFAFAF9),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  currentStatus,
                  style: TextStyle(fontSize: 20, fontFamily: 'bodyMedium'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
