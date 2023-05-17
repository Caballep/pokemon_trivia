import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class SplashPokemon {
  final String frontSpriteUrl;
  final String name;

  SplashPokemon({
    required this.frontSpriteUrl,
    required this.name,
  });

  factory SplashPokemon.fromPokemonModel(PokemonModel pokemonModel) {
    return SplashPokemon(
      frontSpriteUrl: pokemonModel.frontSpriteUrl,
      name: pokemonModel.name,
    );
  }
}
