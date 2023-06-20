import 'package:pokemon_trivia/core/helpers/list_helper.dart';
import 'package:pokemon_trivia/core/helpers/string_transformers.dart';
import 'package:pokemon_trivia/data/source/remote/dto/generation_details_dto.dart';
import 'package:pokemon_trivia/data/source/remote/dto/generation_dto.dart';
import 'package:pokemon_trivia/data/source/remote/dto/region_dto.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';

class GenerationEntity {
  final String code;
  final int startsWith;
  final int endsWith;
  final String mainRegionName;
  final GenerationEntityAccessState acessState;

  GenerationEntity(
      {required this.code,
      required this.startsWith,
      required this.endsWith,
      required this.mainRegionName,
      required this.acessState});

  factory GenerationEntity.from(GenerationDto generationDto,
      GenerationDetailsDto generationDetailsDto, RegionDto regionDto) {
    final code = extractRomanNumeral(generationDto.name);
    final startingPokemonUrl = generationDetailsDto.pokemonSpeciesUrlDto.first;
    final startingPokemonId = getLastNumberFromUrl(startingPokemonUrl.url);

    final pokemonsUrl =
        generationDetailsDto.pokemonSpeciesUrlDto.map((e) => e.url).toList();

    final lastPokemonId = getOrderedPokemonNumbersFromUrls(pokemonsUrl).last;
    final regionName = capitalizeFirstLetter(regionDto.name);

    return GenerationEntity(
      code: code,
      startsWith: startingPokemonId,
      endsWith: lastPokemonId,
      mainRegionName: regionName,
      acessState: GenerationEntityAccessState.locked
    );
  }
}

enum GenerationEntityAccessState {
  locked,
  available,
  pokemonsFetched;

  int getIntFromGenerationAccessState() {
    switch (this) {
      case locked:
        return 1;
      case available:
        return 2;
      case pokemonsFetched:
        return 3;
    }
  }

  static GenerationEntityAccessState getGenerationAccessStateFromInt(
      int value) {
    switch (value) {
      case 1:
        return locked;
      case 2:
        return available;
      case 3:
        return pokemonsFetched;
    }
    return locked;
  }

  static GenerationEntityAccessState from(
      GenerationAccessState generationAccessState) {
    switch (generationAccessState) {
      case GenerationAccessState.locked:
        return locked;
      case GenerationAccessState.available:
        return available;
      case GenerationAccessState.pokemonsFetched:
        return pokemonsFetched;
    }
  }
}
