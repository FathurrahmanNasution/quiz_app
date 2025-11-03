import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../config/router.dart';
import '../utils/responsive_helper.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isNameValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateName);
  }

  void _validateName() {
    setState(() {
      _isNameValid = _nameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (_isNameValid) {
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);
      final userName = _nameController.text.trim();
      quizProvider.setUserName(userName);

      // show welcome then navigate after short delay
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome $userName!'),
          backgroundColor: Colors.black87,
          duration: const Duration(milliseconds: 700),
        ),
      );

      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          // go to trivia (or quiz, depending on your flow)
          context.go(AppRoutes.trivia);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder so rotation triggers new constraints
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isPortrait = constraints.maxHeight > constraints.maxWidth;
              final logoSize = isPortrait
                  ? constraints.maxWidth * 0.4
                  : constraints.maxHeight * 0.3;
              final spacingLarge = constraints.maxHeight * 0.06;
              final spacingMedium = constraints.maxHeight * 0.03;

              return SingleChildScrollView(
                child: Padding(
                  padding: ResponsiveHelper.getHorizontalPadding(context),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.08),
                      // KMNZ Logo
                      Container(
                        width: logoSize,
                        height: logoSize,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.16 * 255).round()),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(logoSize * 0.5),
                          child: Image.asset(
                            'assets/images/kmnz_logo.png',
                            fit: BoxFit.contain,
                            width: logoSize,
                            height: logoSize,
                          ),
                        ),
                      ),
                      SizedBox(height: spacingMedium),
                      Text(
                        'Quiz App',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 28),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      Text(
                        'Test Your Knowledge!',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 14),
                          color: Colors.white.withAlpha((0.95 * 255).round()),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spacingLarge),
                      // Name Input Card
                      Container(
                        padding: EdgeInsets.all(constraints.maxWidth * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.14 * 255).round()),
                          borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
                          border: Border.all(
                            color: Colors.white.withAlpha((0.26 * 255).round()),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Your Name',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(context, 16),
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            TextField(
                              controller: _nameController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveHelper.getFontSize(context, 16),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Your name here...',
                                hintStyle: TextStyle(
                                  color: Colors.white.withAlpha((0.6 * 255).round()),
                                ),
                                filled: true,
                                fillColor: Colors.white.withAlpha((0.08 * 255).round()),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(constraints.maxWidth * 0.03),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: constraints.maxHeight * 0.02,
                                  horizontal: constraints.maxWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      // Start Button
                      CustomButton(
                        text: 'Start Quiz',
                        onPressed: _isNameValid ? _startQuiz : () {},
                        backgroundColor:
                            _isNameValid ? Colors.white : Colors.white.withAlpha((0.5 * 255).round()),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.03),
                      // Info Card
                      Container(
                        padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.1 * 255).round()),
                          borderRadius: BorderRadius.circular(constraints.maxWidth * 0.03),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: constraints.maxWidth * 0.03),
                            Expanded(
                              child: Text(
                                '10 questions with multiple choice, Good luck!',
                                style: TextStyle(
                                  color: Colors.white.withAlpha((0.9 * 255).round()),
                                  fontSize: ResponsiveHelper.getFontSize(context, 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.04),
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
}