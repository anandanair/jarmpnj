import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jarmpnj/utils/material3_theme.dart';
import 'package:jarmpnj/widget_tree.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const basilTheme = BasilTheme();
    return MaterialApp(
      title: 'JARMPNJ',
      theme: basilTheme.toThemeData(),
      home: const WidgetTree(),
    );
  }
}
