import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = ResponsiveHelper.getMaxWidth(context);
        return Stack(
          fit: StackFit.expand,
          children: [
            // Background image (cover) + dark overlay for readability
            Image.asset(
              'assets/images/kmnz_bg.png',
              fit: BoxFit.cover,
            ),
            Container(color: Colors.black.withValues(alpha: 0.45)),
            // Centered responsive content area
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      maxWidth == double.infinity ? constraints.maxWidth : maxWidth,
                ),
                child: Padding(
                  padding: ResponsiveHelper.getHorizontalPadding(context),
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}