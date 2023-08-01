import 'dart:io';

import 'package:flutter/services.dart';

class PokemonDexData {
  final int number;
  final String name;
  final File imageFile;
  final String mainType;
  final String generationCode;
  final String regionName;
  final Color color;

  PokemonDexData(this.number, this.name, this.imageFile, this.mainType, this.generationCode,
      this.regionName, this.color);
}
