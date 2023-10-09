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
      "I": const Color.fromARGB(255, 228, 105, 105), // Red
      "II": const Color(0xFFFF8A65), // Deep Orange
      "III": const Color(0xFFFFD54F), // Amber
      "IV": const Color(0xFFAED581), // Light Green
      "V": const Color(0xFF4DB6AC), // Teal
      "VI": const Color(0xFF2196F3), // Blue
      "VII": const Color.fromARGB(255, 134, 82, 225), // Light Blue
      "VIII": const Color(0xFF9C27B0), // Purple
      "IX": const Color(0xFF795548), // Brown
      "X": const Color(0xFFE57373), // Red
      "XI": const Color(0xFFFF8A65), // Deep Orange
      "XII": const Color(0xFFFFD54F), // Amber
      "XIII": const Color(0xFFAED581), // Light Green
      "XIV": const Color(0xFF4DB6AC), // Teal
      "XV": const Color(0xFF2196F3), // Blue
      "XVI": const Color.fromARGB(255, 134, 82, 225), // Light Blue
      "XVII": const Color(0xFF9C27B0), // Purple
      "XVIII": const Color(0xFF795548), // Brown
    };

    return colorMap[generationCode] ?? Colors.black;
  }
}
