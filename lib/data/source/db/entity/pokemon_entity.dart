import 'package:pokemon_trivia/data/source/remote/dto/pokemon_dto.dart';

class PokemonEntity {
  final int number;
  final String name;
  final String frontSprite;
  final String mainType;

  PokemonEntity({
    required this.number,
    required this.name,
    required this.frontSprite,
    required this.mainType,
  });

  factory PokemonEntity.fromDto(PokemonDto dto) {
    return PokemonEntity(
      number: dto.number,
      name: dto.name,
      frontSprite: dto.frontSprite,
      mainType: dto.mainType,
    );
  }
}
