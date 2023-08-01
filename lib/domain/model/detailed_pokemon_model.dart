import 'dart:io';

import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class DetailedPokemonModel {
  final int number;
  final String name;
  final File imageFile;
  final String mainType;
  final String generationCode;
  final String regionName;

  DetailedPokemonModel(
      {required this.number,
      required this.name,
      required this.imageFile,
      required this.mainType,
      required this.generationCode,
      required this.regionName});

  factory DetailedPokemonModel.from(PokemonModel pokemonModel, GenerationModel generationModel) {
    return DetailedPokemonModel(
        number: pokemonModel.number,
        name: pokemonModel.name,
        imageFile: pokemonModel.imageFile,
        mainType: pokemonModel.mainType,
        generationCode: generationModel.code,
        regionName: generationModel.mainRegionName);
  }
}
