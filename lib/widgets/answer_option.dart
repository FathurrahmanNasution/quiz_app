import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String option;
  final String label;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.option,
    required this.label,
    required this.isSelected,
    this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Color getBackgroundColor() {
      if (isCorrect != null) {
        if (isCorrect!) {
          return Colors.green.withAlpha((0.2 * 255).round());
        } else if (isSelected) {
          return Colors.red.withAlpha((0.2 * 255).round());
        }
      } else if (isSelected) {
        return Colors.white.withAlpha((0.3 * 255).round());
      }
      return Colors.white.withAlpha((0.1 * 255).round());
    }

    Color getBorderColor() {
      if (isCorrect != null) {
        if (isCorrect!) {
          return Colors.green;
        } else if (isSelected) {
          return Colors.red;
        }
      } else if (isSelected) {
        return Colors.white;
      }
      return Colors.white.withAlpha((0.3 * 255).round());
    }

    return GestureDetector(
      onTap: isCorrect == null ? onTap : null,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          border: Border.all(
            color: getBorderColor(),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration: BoxDecoration(
                color: getBorderColor(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isCorrect != null && isCorrect!)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: screenWidth * 0.06,
              ),
            if (isCorrect != null && isSelected && !isCorrect!)
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: screenWidth * 0.06,
              ),
          ],
        ),
      ),
    );
  }
}