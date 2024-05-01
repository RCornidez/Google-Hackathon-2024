import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/landing_page.dart';
import 'services/socket_service.dart';
import 'services/logger_service.dart';

Future<void> main() async {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  static final Future<void> _initFuture = _initApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trees Bees & Seas',
      theme: _buildAppTheme(),
      home: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              Log.error('Failed to initialize the app', snapshot.error);
              return const Center(
                  child: Text('Failed to load the application'));
            }
            return const LandingPage();
          }
          // Show loading indicator while the app is initializing
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      textTheme: GoogleFonts.notoSansTextTheme().copyWith(
        // Title Fonts
        displayLarge: GoogleFonts.rubik(),
        displayMedium: GoogleFonts.rubik(),
        displaySmall: GoogleFonts.rubik(),
        headlineMedium: GoogleFonts.rubik(),
        headlineSmall: GoogleFonts.rubik(),
        titleLarge: GoogleFonts.rubik(),
        // Body Fonts
        titleMedium: GoogleFonts.notoSans(),
        titleSmall: GoogleFonts.notoSans(),
        bodyLarge: GoogleFonts.notoSans(),
        bodyMedium: GoogleFonts.notoSans(),
        bodySmall: GoogleFonts.notoSans(),
        labelSmall: GoogleFonts.notoSans(),
      ),
    );
  }
}

Future<void> _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Log.init();
    Log.info("Initialized Flutter Application: Bees Trees & Seas");
    SocketService();
  } catch (e, stackTrace) {
    Log.error('Error during initialization', e, stackTrace);
    rethrow;
  }
}
