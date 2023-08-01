import 'package:pokemon_trivia/data/source/local/db/entity/pokemon_entity.dart';
import 'dart:io';

class PokemonModel {
  final int number;
  final String name;
  final File imageFile;
  final String mainType;

  PokemonModel({
    required this.number,
    required this.name,
    required this.imageFile,
    required this.mainType,
  });

  factory PokemonModel.fromPokemonEntity(PokemonEntity pokemonEntity, File imageFile) {
    return PokemonModel(
      number: pokemonEntity.number,
      name: pokemonEntity.name,
      imageFile: imageFile,
      mainType: pokemonEntity.mainType,
    );
  }
}
