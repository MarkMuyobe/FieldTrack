import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/screens.dart';
import 'pages/login_page.dart';
import 'pages/sign_up.dart';
import 'mad_theme.dart';
import 'pages/greeting.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final theme = MadTheme.dark();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: theme,
      home: const GreetingPage(), // Set the GreetingPage as the first page
      routes: {
        'Screen3': (context) => Screen3(),
        '/login': (context) => const LoginPage(), // Route for LoginPage
        '/signup': (context) => const SignUpPage(), // Route for SignUpPage
        '/greeting': (context) => const GreetingPage(), // Route for GreetingPage
      },
    );
  }
}
