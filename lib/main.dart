import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/config/router.dart';
import 'package:quiz_app/utils/responsive_helper.dart';
import 'providers/quiz_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final quizProvider = QuizProvider();
  final routerConfig = createRouter(quizProvider);
  
  runApp(
    ChangeNotifierProvider.value(
      value: quizProvider,
      child: QuizApp(
        quizProvider: quizProvider,
        routerConfig: routerConfig,
      ),
    ),
  );
}

class QuizApp extends StatelessWidget {
  final QuizProvider quizProvider;
  final GoRouter routerConfig;

  const QuizApp({
    super.key,
    required this.quizProvider,
    required this.routerConfig,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KMNZ Quiz',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(ResponsiveHelper.getFontSize(context, 1.0)),
          ),
          child: child!,
        );
      },
    );
  }
}