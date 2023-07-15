import 'package:flutter/services.dart';

class PokemonDexData {
  final int number;
  final String name;
  final String frontSpriteUrl;
  final String mainType;
  final String generationCode;
  final String regionName;
  final Color color;

  PokemonDexData(this.number, this.name, this.frontSpriteUrl, this.mainType, this.generationCode,
      this.regionName, this.color);
}
