import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'landing_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to the LandingPage after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, // Screen width
          height: MediaQuery.of(context).size.height, // Screen height
          child: Lottie.asset(
            'assets/lottie_tree_loading_screen.json',
            fit: BoxFit.cover, // Make the animation fill the available space
          ),
        ),
      ),
    );
  }
}
