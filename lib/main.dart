import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/screens.dart';
import 'view/login_page.dart';
import 'view/sign_up.dart';
import 'model/mad_theme.dart';
import 'view/greeting.dart';

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
      debugShowCheckedModeBanner: false,
      home: const GreetingPage(), // Set the GreetingPage as the first page
      routes: {
        '/homepage': (context) => MyHomePage(title: 'FieldTrack'),
        'Screen3': (context) => Screen3(),
        '/login': (context) => const LoginPage(), // Route for LoginPage
        '/signup': (context) => const SignUpPage(), // Route for SignUpPage
        '/greeting': (context) => const GreetingPage(), // Route for GreetingPage
      },
    );
  }
}
