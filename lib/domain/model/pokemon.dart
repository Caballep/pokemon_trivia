import 'package:pokemon_trivia/data/source/db/entity/pokemon_entity.dart';

class Pokemon {
  final int number;
  final String name;
  final String frontSprite;
  final String mainType;

  Pokemon({
    required this.number,
    required this.name,
    required this.frontSprite,
    required this.mainType,
  });

  factory Pokemon.fromPokemonEntity(PokemonEntity pokemonEntity) {
    return Pokemon(
      number: pokemonEntity.number,
      name: pokemonEntity.name,
      frontSprite: pokemonEntity.frontSprite,
      mainType: pokemonEntity.mainType,
    );
  }
}
