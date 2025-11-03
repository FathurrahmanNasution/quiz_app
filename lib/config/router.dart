import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/welcome_page.dart';
import '../screens/trivia_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';
import '../providers/quiz_provider.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String trivia = '/trivia';
  static const String quiz = '/quiz';
  static const String result = '/result';
}

GoRouter createRouter(QuizProvider quizProvider) {
  return GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.trivia,
        name: 'trivia',
        builder: (context, state) => const TriviaScreen(),
      ),
      GoRoute(
        path: AppRoutes.quiz,
        name: 'quiz',
        builder: (context, state) => QuizScreen(quizProvider: quizProvider),
      ),
      GoRoute(
        path: AppRoutes.result,
        name: 'result',
        builder: (context, state) => ResultScreen(quizProvider: quizProvider),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.welcome),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}