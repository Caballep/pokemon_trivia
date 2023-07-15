import 'dart:collection';
import 'package:flutter/material.dart';

class PokemonColorTypeUtil {
  static HashMap<String, Color> typeColorMap = HashMap<String, Color>.from({
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

  static Color getColorFromType(String typeName) {
    return typeColorMap[typeName] ?? Colors.tealAccent;
  }
}
