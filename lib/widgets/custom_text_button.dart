
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, 
  required this.onPressed, 
  required this.buttonText, 
  required this.textColor, 
  required this.fontSize
  });
  final VoidCallback onPressed;
  final String buttonText;
  final Color textColor;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text(
        buttonText,
        style: TextStyle(color: textColor,fontSize: fontSize),
      )
      );

  }
}