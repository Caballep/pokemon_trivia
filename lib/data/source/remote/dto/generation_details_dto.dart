import 'package:pokemon_trivia/data/source/remote/dto/pokemon_specie_url_dto.dart';

class GenerationDetailsDto {
  final String mainRegionUrl;
  final List<PokemonSpecieUrlDto> pokemonSpeciesUrlDto;

  GenerationDetailsDto({
    required this.mainRegionUrl,
    required this.pokemonSpeciesUrlDto,
  });

  factory GenerationDetailsDto.fromJson(Map<String, dynamic> json) {
    final mainRegionUrl = json['main_region']['url'] as String;
    final pokemonSpecies = json['pokemon_species'] as List<dynamic>;
    final pokemonSpeciesUrlDto = pokemonSpecies
        .map((species) => PokemonSpecieUrlDto(
              name: species['name'] as String,
              url: species['url'] as String,
            ))
        .toList();

    return GenerationDetailsDto(
      mainRegionUrl: mainRegionUrl,
      pokemonSpeciesUrlDto: pokemonSpeciesUrlDto,
    );
  }
}
