import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;
import 'package:pokemon_trivia/presentation/utils/media_query_util.dart';

class RetroText extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;

  final screenWidth = MediaQueryUtil.width;

  RetroText({Key? key, required this.text, required this.color, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fontSize != null
        ? MultiLineRetroText(text: text, color: color, fontSize: fontSize!)
        : SingleLineRetroText(
            text: text,
            color: color,
          );
  }
}

class MultiLineRetroText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  final screenWidth = MediaQueryUtil.width;

  MultiLineRetroText({Key? key, required this.text, required this.color, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: gf.GoogleFonts.vt323(fontSize: fontSize, color: color),
    );
  }
}

class SingleLineRetroText extends StatelessWidget {
  final String text;
  final Color color;

  final screenWidth = MediaQueryUtil.width;

  SingleLineRetroText({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Text(
          text,
          style: gf.GoogleFonts.vt323(fontSize: screenWidth, color: color),
          maxLines: 1,
        ),
      ),
    );
  }
}
