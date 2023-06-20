import 'package:pokemon_trivia/core/helpers/string_transformers.dart';
import 'package:pokemon_trivia/data/source/remote/dto/pokemon_dto.dart';

class PokemonEntity {
  final int number;
  final String name;
  final String frontSpriteUrl;
  final String mainType;

  PokemonEntity({
    required this.number,
    required this.name,
    required this.frontSpriteUrl,
    required this.mainType,
  });

  factory PokemonEntity.fromDto(PokemonDto dto) {
    return PokemonEntity(
      number: dto.number,
      name: capitalizeFirstLetter(dto.name),
      frontSpriteUrl: dto.frontSpriteUrl,
      mainType: dto.mainType,
    );
  }
}
