import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/gradient_background.dart';
import '../widgets/custom_button.dart';
import '../config/router.dart';
import '../utils/responsive_helper.dart';

class TriviaScreen extends StatelessWidget {
  const TriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final logoSize = constraints.maxWidth * 0.35;
              
              return SingleChildScrollView(
                padding: ResponsiveHelper.getHorizontalPadding(context),
                child: Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.02),
                    
                    // KMNZ Logo
                    Container(
                      width: logoSize,
                      height: logoSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha((0.2 * 255).round()),
                        borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
                        child: Image.asset(
                          'assets/images/kmnz_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: constraints.maxHeight * 0.03),

                    Text(
                      'KMNZ Trivia',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 24),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: constraints.maxHeight * 0.02),

                    _buildInfoSection(
                      context,
                      constraints,
                      'Origin & History',
                      '• KMNZ debuted as a VTuber unit on May 25, 2018\n'
                      '• Original members were LITA and LIZ\n'
                      '• Name "KMNZ" comes from Japanese word "kemono" (animal)',
                    ),

                    SizedBox(height: constraints.maxHeight * 0.02),

                    _buildInfoSection(
                      context,
                      constraints,
                      'Music Style',
                      '• Main genre: Hip-hop/rap with J-pop influence\n'
                      '• Features electronic and dance elements\n'
                      '• Released KMNVERSE album in 2019\n'
                      '• Known for collaborations with music producers',
                    ),

                    SizedBox(height: constraints.maxHeight * 0.02),

                    _buildInfoSection(
                      context,
                      constraints,
                      'Recent Changes',
                      '• LIZ announced graduation effective end of 2023\n'
                      '• NERO and TINA joined in 2024\n'
                      '• Current lineup: LITA, NERO, and TINA',
                    ),

                    SizedBox(height: constraints.maxHeight * 0.02),

                    _buildInfoSection(
                      context,
                      constraints,
                      'Brand Identity',
                      '• Managed by REALITY/RK Music\n'
                      '• Distinctive animal-eared character designs\n'
                      '• Unique visual style in music videos\n'
                      '• Known for innovative virtual performances',
                    ),

                    SizedBox(height: constraints.maxHeight * 0.04),

                    CustomButton(
                      text: 'Start KMNZ Quiz',
                      onPressed: () => context.go(AppRoutes.quiz),
                    ),

                    SizedBox(height: constraints.maxHeight * 0.02),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    BoxConstraints constraints,
    String title,
    String content,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(constraints.maxWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha((0.15 * 255).round()),
        borderRadius: BorderRadius.circular(constraints.maxWidth * 0.04),
        border: Border.all(
          color: Colors.white.withAlpha((0.3 * 255).round()),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: constraints.maxWidth * 0.02),
          Text(
            content,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 14),
              color: Colors.white.withAlpha((0.9 * 255).round()),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}