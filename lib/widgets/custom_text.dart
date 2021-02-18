import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final double letterSpacing, fontSize, height;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final String text;

  CustomText(this.text,
      {this.fontSize,
      this.color : Colors.white,
      this.fontWeight,
      this.letterSpacing,
      this.textAlign,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          height: height,
          fontFamily: 'Quicksand',
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing),
    );
  }
}
