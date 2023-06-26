import 'package:flutter/material.dart';
import 'package:sl_front/themes/light_theme.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SLKTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
