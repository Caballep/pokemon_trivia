import 'package:flutter/material.dart';

class RegionOptionColorUtil {
  Color convertToColor(String romanNumeral) {
    final Map<String, Color> colorMap = {
      "I": const Color(0xFFE57373),
      "II": const Color(0xFFFF8A65),
      "III": const Color(0xFFFFD54F),
      "IV": const Color(0xFF81C784),
      "V": const Color(0xFF64B5F6),
      "VI": const Color(0xFF9575CD),
      "VII": const Color(0xFF4DB6AC),
      "VIII": const Color(0xFFDCE775),
      "IX": const Color(0xFFAED581),
      "X": const Color(0xFFFFD54F),
      "XI": const Color(0xFF81C784),
      "XII": const Color(0xFF64B5F6),
      "XIII": const Color(0xFF9575CD),
      "XIV": const Color(0xFF4DB6AC),
      "XV": const Color(0xFFDCE775),
      "XVI": const Color(0xFFAED581),
      "XVII": const Color(0xFFE57373),
      "XVIII": const Color(0xFFFF8A65),
      "XIX": const Color(0xFFFFD54F),
      "XX": const Color(0xFF81C784),
    };

    return colorMap[romanNumeral] ?? Colors.black;
  }
}
