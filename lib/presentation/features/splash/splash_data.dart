import 'dart:io';

import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class SplashPokemon {
  final File imageFile;
  final String name;

  SplashPokemon({
    required this.imageFile,
    required this.name,
  });

  factory SplashPokemon.fromPokemonModel(PokemonModel pokemonModel) {
    return SplashPokemon(
      imageFile: pokemonModel.imageFile,
      name: pokemonModel.name,
    );
  }
}
