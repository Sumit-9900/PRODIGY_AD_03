import 'package:flutter/material.dart';
import 'package:stopwatch/screens.dart/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          // backgroundColor: Color.fromARGB(175, 0, 0, 0),
          backgroundColor: Color.fromARGB(255, 43, 19, 109),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            // backgroundColor: const Color.fromARGB(175, 0, 0, 0),
            foregroundColor: const Color.fromARGB(215, 255, 255, 255),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 110, 88, 199),
            foregroundColor: const Color.fromARGB(215, 255, 255, 255),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 91, 55, 232),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
