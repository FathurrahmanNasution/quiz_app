import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_data.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _currentQuestionIndex = 0;
  final List<int?> _userAnswers = List.filled(QuizData.questions.length, null);
  bool _isAnswerChecked = false;

  // Getters
  String get userName => _userName;
  int get currentQuestionIndex => _currentQuestionIndex;
  List<int?> get userAnswers => _userAnswers;
  bool get isAnswerChecked => _isAnswerChecked;
  
  Question get currentQuestion => QuizData.questions[_currentQuestionIndex];
  int get totalQuestions => QuizData.questions.length;
  
  int? get currentUserAnswer => _userAnswers[_currentQuestionIndex];
  
  bool get isLastQuestion => _currentQuestionIndex == totalQuestions - 1;
  
  int get score {
    int correctAnswers = 0;
    for (int i = 0; i < QuizData.questions.length; i++) {
      if (_userAnswers[i] == QuizData.questions[i].correctAnswerIndex) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }

  double get scorePercentage => (score / totalQuestions) * 100;

  // Methods
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void selectAnswer(int index) {
    if (!isAnswerChecked) {
      _userAnswers[_currentQuestionIndex] = index;
      notifyListeners();
    }
  }

  void checkAnswer() {
    if (!isAnswerChecked && currentUserAnswer != null) {
      _isAnswerChecked = true;
      notifyListeners();
    }
  }

  void nextQuestion() {
    if (isAnswerChecked && !isLastQuestion) {
      _currentQuestionIndex++;
      _isAnswerChecked = false;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _isAnswerChecked = false;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _userAnswers.fillRange(0, _userAnswers.length, null);
    _isAnswerChecked = false;
    _userName = '';
    notifyListeners();
  }

  bool isAnswerCorrect(int questionIndex) {
    return _userAnswers[questionIndex] ==
        QuizData.questions[questionIndex].correctAnswerIndex;
  }
}