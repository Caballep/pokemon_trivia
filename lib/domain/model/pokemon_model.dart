import 'package:pokemon_trivia/data/source/local/db/entity/pokemon_entity.dart';

class PokemonModel {
  final int number;
  final String name;
  final String frontSpriteUrl;
  final String mainType;

  PokemonModel({
    required this.number,
    required this.name,
    required this.frontSpriteUrl,
    required this.mainType,
  });

  factory PokemonModel.fromPokemonEntity(PokemonEntity pokemonEntity) {
    return PokemonModel(
      number: pokemonEntity.number,
      name: pokemonEntity.name,
      frontSpriteUrl: pokemonEntity.frontSpriteUrl,
      mainType: pokemonEntity.mainType,
    );
  }
}
