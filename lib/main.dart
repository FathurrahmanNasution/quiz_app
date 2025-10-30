import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Quiz App - Initial Setup'),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}