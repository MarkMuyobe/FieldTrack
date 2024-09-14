import 'package:flutter/material.dart';
import 'pages/screens.dart';
import 'mad_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final theme = MadTheme.dark();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: theme,
      home: const WidgetTree(),
      routes: {
        'Screen1' : (context) => Screen1(),
        'Screen2' : (context) => const Screen2(),
        'Screen3' : (context) => Screen3(),
      },
    );
  }
}

