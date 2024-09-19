import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final double fontSize;
  final String? fontFamily;

  const GradientText(
      this.text, {
        required this.gradient,
        this.fontSize = 40.0,
        this.fontFamily,
      });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: fontFamily, // Optional: Apply the custom font if needed
          color: Colors.white,    // The color is required but won't be visible due to the gradient
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}