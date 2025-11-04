import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../providers/quiz_provider.dart';
import '../widgets/gradient_background.dart';
import '../widgets/answer_option.dart';
import '../widgets/custom_button.dart';
import '../utils/responsive_helper.dart';
import '/config/router.dart';

class QuizScreen extends StatelessWidget {
  final QuizProvider quizProvider;

  const QuizScreen({super.key, required this.quizProvider});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: quizProvider,
      builder: (context, child) {
        return GradientBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      // Header
                      Container(
                        padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back button
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: ResponsiveHelper.getFontSize(context, 24),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text('Exit Quiz?'),
                                        content: const Text(
                                            'Your progress will be lost. Are you sure?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx);
                                              quizProvider.resetQuiz();
                                              context.go(AppRoutes.trivia);
                                            },
                                            child: const Text('Exit'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                // User name
                                Flexible(
                                  child: Text(
                                    quizProvider.userName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ResponsiveHelper.getFontSize(context, 16),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Question counter
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.03,
                                    vertical: constraints.maxHeight * 0.008,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha((0.2 * 255).round()),
                                    borderRadius:
                                        BorderRadius.circular(constraints.maxWidth * 0.05),
                                  ),
                                  child: Text(
                                    '${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ResponsiveHelper.getFontSize(context, 14),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            // Progress bar
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(constraints.maxWidth * 0.02),
                              child: LinearProgressIndicator(
                                value: (quizProvider.currentQuestionIndex + 1) /
                                    quizProvider.totalQuestions,
                                backgroundColor: Colors.white.withAlpha((0.3 * 255).round()),
                                valueColor:
                                    const AlwaysStoppedAnimation<Color>(Colors.white),
                                minHeight: constraints.maxHeight * 0.01,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Question and answers
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question card
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(constraints.maxWidth * 0.05),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha((0.15 * 255).round()),
                                  borderRadius:
                                      BorderRadius.circular(constraints.maxWidth * 0.04),
                                  border: Border.all(
                                    color: Colors.white.withAlpha((0.3 * 255).round()),
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  quizProvider.currentQuestion.question,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveHelper.getFontSize(context, 18),
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                                ),
                              ),

                              SizedBox(height: constraints.maxHeight * 0.03),

                              // Answer options
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    quizProvider.currentQuestion.options.length,
                                itemBuilder: (context, index) {
                                  final option =
                                      quizProvider.currentQuestion.options[index];
                                  final labels = ['A', 'B', 'C', 'D'];
                                  final isSelected =
                                      quizProvider.currentUserAnswer == index;

                                  bool? isCorrect;
                                  if (quizProvider.isAnswerChecked) {
                                    if (index ==
                                        quizProvider
                                            .currentQuestion.correctAnswerIndex) {
                                      isCorrect = true;
                                    } else if (isSelected) {
                                      isCorrect = false;
                                    }
                                  }

                                  return AnswerOption(
                                    option: option,
                                    label: labels[index],
                                    isSelected: isSelected,
                                    isCorrect: isCorrect,
                                    onTap: () => quizProvider.selectAnswer(index),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Bottom buttons
                      Container(
                        padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                        child: Column(
                          children: [
                            if (!quizProvider.isAnswerChecked)
                              CustomButton(
                                text: 'Check Answer',
                                onPressed: quizProvider.currentUserAnswer != null
                                    ? () => quizProvider.checkAnswer()
                                    : () {},
                                backgroundColor:
                                    quizProvider.currentUserAnswer != null
                                        ? Colors.white
                                        : Colors.white.withAlpha((0.5 * 255).round()),
                              )
                            else
                              CustomButton(
                                text: quizProvider.isLastQuestion
                                    ? 'Finish Quiz'
                                    : 'Next Question',
                                onPressed: () {
                                  if (quizProvider.isLastQuestion) {
                                    context.go(AppRoutes.result);
                                  } else {
                                    quizProvider.nextQuestion();
                                  }
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}