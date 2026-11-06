import 'package:flutter/material.dart';
import 'screens/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CaseBoomApp());
}

class CaseBoomApp extends StatelessWidget {
  const CaseBoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF090B12);
    return MaterialApp(
      title: 'CASE BOOM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7657FF),
          brightness: Brightness.dark,
          surface: const Color(0xFF141827),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const AppShell(),
    );
  }
}
