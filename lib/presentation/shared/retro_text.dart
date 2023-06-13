import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;

enum RetroTextSize { huge, big, medium, small, tiny }

class RetroText extends StatelessWidget {
  final String text;
  final RetroTextSize retroTextSize;
  final FontWeight fontWeight;
  final Color color;

  const RetroText({
    Key? key,
    required this.text,
    required this.retroTextSize,
    this.fontWeight = FontWeight.normal,
    required this.color,
  }) : super(key: key);

  double _getTextSize() {
    switch (retroTextSize) {
      case RetroTextSize.huge:
        return 60.0;
      case RetroTextSize.big:
        return 45.0;
      case RetroTextSize.medium:
        return 35.0;
      case RetroTextSize.small:
        return 28.0;
      case RetroTextSize.tiny:
        return 18.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: gf.GoogleFonts.vt323(
        fontSize: _getTextSize(),
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
