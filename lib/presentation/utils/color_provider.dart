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
      "I": const Color(0xFFE57373), // Red
      "II": const Color(0xFFFF8A65), // Deep Orange
      "III": const Color(0xFFFFD54F), // Amber
      "IV": const Color(0xFF2196F3), // Blue
      "V": const Color(0xFF9C27B0), // Purple
      "VI": const Color(0xFF9575CD), // Light Blue
      "VII": const Color(0xFF4DB6AC), // Teal
      "VIII": const Color(0xFFDCE775), // Lime
      "IX": const Color(0xFFAED581), // Light Green
      "X": const Color(0xFF03A9F4), // Light Blue
      "XI": const Color(0xFFE91E63), // Pink
      "XII": const Color(0xFF795548), // Brown
      "XIII": const Color(0xFF9E9E9E), // Grey
      "XIV": const Color(0xFFFFC107), // Yellow
      "XV": const Color(0xFF8BC34A), // Light Green
      "XVI": const Color(0xFFEF5350), // Red
      "XVII": const Color(0xFFFF9800), // Orange
      "XVIII": const Color(0xFFCDDC39), // Lime Green
      "XIX": const Color(0xFF00BCD4), // Cyan
      "XX": const Color(0xFF8E24AA), // Purple
    };

    return colorMap[generationCode] ?? Colors.black;
  }
}
