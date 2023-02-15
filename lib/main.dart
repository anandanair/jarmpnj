import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jarmpnj/providers/progress_provider.dart';
import 'package:jarmpnj/widget_tree.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProgressModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Build Theme
  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorSchemeSeed: brightness == Brightness.dark
          ? const Color.fromARGB(255, 7, 66, 143)
          : const Color.fromARGB(255, 20, 37, 5),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.comicNeueTextTheme(baseTheme.textTheme),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JARMPNJ',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const WidgetTree(),
    );
  }
}
