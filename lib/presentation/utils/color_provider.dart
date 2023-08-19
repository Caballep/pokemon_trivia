import 'dart:collection';
import 'package:flutter/material.dart';

class ColorProvider {
  static Color getColorFromPokemonType(String typeName) {
    final Map<String, Color> typeColorMap = HashMap<String, Color>.from({
      'normal': Colors.orange,
      'fighting': Colors.indigoAccent,
      'flying': Colors.cyan[100],
      'poison': Colors.purple,
      'ground': Colors.brown,
      'rock': Colors.grey,
      'bug': Colors.lightGreen,
      'ghost': Colors.deepPurple,
      'steel': Colors.blueGrey,
      'fire': Colors.red[700],
      'water': Colors.blue,
      'grass': Colors.green,
      'electric': Colors.yellow[600],
      'psychic': Colors.pink,
      'ice': Colors.cyan,
      'dragon': Colors.deepOrange,
      'dark': Colors.black87,
      'fairy': Colors.pink[300],
    });
    return typeColorMap[typeName] ?? Colors.tealAccent;
  }

  static Color getColorFromGenerationCode(String generationCode) {
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

    return colorMap[generationCode] ?? Colors.black;
  }
}
