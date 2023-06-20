import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

enum RetroTextSize { gigantic, huge, big, medium, small, tiny }

class RetroText extends StatelessWidget {
  final String text;
  final RetroTextSize retroTextSize;
  final FontWeight fontWeight;
  final Color color;

  final screenHeight = MediaQueryUtil.height;

  RetroText({
    Key? key,
    required this.text,
    required this.retroTextSize,
    this.fontWeight = FontWeight.normal,
    required this.color,
  }) : super(key: key);

  double _getTextSize() {
    switch (retroTextSize) {
      case RetroTextSize.gigantic:
        return screenHeight / 6;
      case RetroTextSize.huge:
        return screenHeight / 9;
      case RetroTextSize.big:
        return screenHeight / 12;
      case RetroTextSize.medium:
        return screenHeight / 16;
      case RetroTextSize.small:
        return screenHeight / 20;
      case RetroTextSize.tiny:
        return screenHeight / 25;
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
