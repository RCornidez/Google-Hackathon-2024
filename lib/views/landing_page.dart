import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math';
import 'loading_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isPickingFile = false; // Track if we're currently picking a file

  List<String> environmentalFacts = [
    "An area the size of a football field in the Amazon rainforest is cleared every second.",
    "Over 8 million tons of plastic waste enter the oceans yearly, harming marine life.",
    "Human activities drive species loss at a rate 1,000 to 10,000 times higher than natural.",
    "Earth's surface temperature has risen by 1.2°C since the 19th century due to human-emitted greenhouse gases.",
    "Half of the world's coral reefs are lost, with projections of 90% disappearing by 2050.",
    "Carbon dioxide absorption has increased ocean acidity by 30%, threatening marine life.",
    "The rate of species extinction exceeds any time in history, with 1 million species at risk.",
    "Fossil fuel combustion causes millions of premature deaths annually and respiratory diseases.",
    "Human activities degrade 33% of Earth's land, leading to biodiversity loss and desertification.",
    "Despite abundant water, over 2 billion people face high water stress, with projections to rise to 5.7 billion by 2050.",
  ];

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

  int environmentalFactIndex = 0;
  int funnyPunIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start the periodic timer to rotate facts
    Stream.periodic(Duration(seconds: 7)).listen((_) {
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
        MaterialPageRoute(builder: (context) => LoadingPage()),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCDDFF3),
              Color(0xFF6A9FDC),
            ],
            stops: [0.0, 1], // Adjust the gradient stops as needed
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  'assets/logo_496_59.9.png',
                  alignment: Alignment.topCenter,
                  height: 180.0,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Did you know?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3C905F),
                    fontFamily: 'headlineMedium',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 100, // Fixed height for the fact text area
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      environmentalFacts[environmentalFactIndex],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'bodyMedium',
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        funnyPuns[funnyPunIndex],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3C905F),
                          fontFamily: 'headlineMedium',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showHowItWorksDialog(context);
                      },
                      child: Text(
                        "How it works",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'bodyMedium',
                          color: Color.fromARGB(255, 184, 10, 10),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: _isPickingFile ? null : () => _pickFiles(context),
                  child: _isPickingFile
                      ? CircularProgressIndicator()
                      : Text("Upload File"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
