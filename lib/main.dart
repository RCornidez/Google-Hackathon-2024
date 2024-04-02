import 'package:flutter/material.dart';
import 'views/loading_page.dart'; // Create this
import 'views/landing_page.dart'; // Create this
import 'views/results_page.dart'; // Create this

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoadingPage(), // Initial loading page
    );
  }
}
