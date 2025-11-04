import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/config/router.dart';
import '../providers/quiz_provider.dart';
import '../widgets/gradient_background.dart';
import '../widgets/custom_button.dart';
import '../utils/responsive_helper.dart';

class ResultScreen extends StatelessWidget {
  final QuizProvider quizProvider;

  const ResultScreen({super.key, required this.quizProvider});

  String _getGradeMessage() {
    final percentage = quizProvider.scorePercentage;
    if (percentage >= 90) return 'Outstanding! 🏆';
    if (percentage >= 80) return 'Excellent! 🌟';
    if (percentage >= 70) return 'Great Job! 👏';
    if (percentage >= 60) return 'Good Effort! 👍';
    return 'Keep Practicing! 💪';
  }

  Color _getGradeColor() {
    final percentage = quizProvider.scorePercentage;
    if (percentage >= 80) return Colors.green;
    if (percentage >= 60) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final iconSize = constraints.maxWidth * 0.25;
              final scoreCircleSize = constraints.maxWidth * 0.35;
              
              return SingleChildScrollView(
                child: Padding(
                  padding: ResponsiveHelper.getHorizontalPadding(context),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.04),

                      // Trophy Icon
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.2 * 255).round()),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.emoji_events,
                          size: iconSize * 0.5,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: constraints.maxHeight * 0.03),

                      // Title
                      Text(
                        'Quiz Completed!',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 28),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: constraints.maxHeight * 0.01),

                      Text(
                        _getGradeMessage(),
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 18),
                          color: Colors.white.withAlpha((0.9 * 255).round()),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: constraints.maxHeight * 0.04),

                      // Score Card
                      Container(
                        padding: EdgeInsets.all(constraints.maxWidth * 0.06),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.15 * 255).round()),
                          borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
                          border: Border.all(
                            color: Colors.white.withAlpha((0.3 * 255).round()),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            // User name
                            Text(
                              quizProvider.userName,
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(context, 20),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: constraints.maxHeight * 0.03),

                            // Score circle
                            Container(
                              width: scoreCircleSize,
                              height: scoreCircleSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _getGradeColor(),
                                  width: 8,
                                ),
                                color: Colors.white.withAlpha((0.1 * 255).round()),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${quizProvider.score}',
                                    style: TextStyle(
                                      fontSize: ResponsiveHelper.getFontSize(context, 48),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'out of ${quizProvider.totalQuestions}',
                                    style: TextStyle(
                                      fontSize: ResponsiveHelper.getFontSize(context, 12),
                                      color: Colors.white.withAlpha((0.8 * 255).round()),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: constraints.maxHeight * 0.03),

                            // Percentage
                            Text(
                              '${quizProvider.scorePercentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(context, 32),
                                fontWeight: FontWeight.bold,
                                color: _getGradeColor(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: constraints.maxHeight * 0.03),

                      // Statistics
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              context,
                              constraints,
                              'Correct',
                              '${quizProvider.score}',
                              Colors.green,
                              Icons.check_circle,
                            ),
                          ),
                          SizedBox(width: constraints.maxWidth * 0.04),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              constraints,
                              'Wrong',
                              '${quizProvider.totalQuestions - quizProvider.score}',
                              Colors.red,
                              Icons.cancel,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: constraints.maxHeight * 0.04),

                      // Single Try Again button
                      CustomButton(
                        text: 'Try Again',
                        onPressed: () {
                          quizProvider.resetQuiz();
                          context.go(AppRoutes.trivia);
                        },
                        backgroundColor: Colors.white,
                      ),
                      
                      SizedBox(height: constraints.maxHeight * 0.02),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    BoxConstraints constraints,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(constraints.maxWidth * 0.04),
      decoration: BoxDecoration(
        color: color.withAlpha((0.2 * 255).round()),
        borderRadius: BorderRadius.circular(constraints.maxWidth * 0.03),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: ResponsiveHelper.getFontSize(context, 28),
          ),
          SizedBox(height: constraints.maxHeight * 0.01),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 28),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 12),
              color: Colors.white.withAlpha((0.8 * 255).round()),
            ),
          ),
        ],
      ),
    );
  }
}