import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trees Bees & Seas',
      theme: ThemeData(
        // Use Rubik for titles and Noto Sans for body text
        textTheme: GoogleFonts.notoSansTextTheme().copyWith(
          // Title font
          displayLarge: GoogleFonts.rubik(), 
          displayMedium: GoogleFonts.rubik(), 
          displaySmall: GoogleFonts.rubik(), 
          headlineMedium: GoogleFonts.rubik(), 
          headlineSmall: GoogleFonts.rubik(),
          titleLarge: GoogleFonts.rubik(), 
          // Body font
          titleMedium: GoogleFonts.notoSans(), 
          titleSmall: GoogleFonts.notoSans(),
          bodyLarge: GoogleFonts.notoSans(), 
          bodyMedium: GoogleFonts.notoSans(), 
          bodySmall: GoogleFonts.notoSans(), 
          labelSmall: GoogleFonts.notoSans(), 
        ),
      ),
      home: LandingPage(), // Set your LandingPage as the home page
    );
  }
}
