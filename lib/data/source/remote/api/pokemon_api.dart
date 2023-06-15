import 'package:http/http.dart' as http;
import 'package:pokemon_trivia/data/source/remote/dto/generation_details_dto.dart';
import 'package:pokemon_trivia/data/source/remote/dto/generation_dto.dart';
import 'dart:convert';
import 'package:pokemon_trivia/data/source/remote/dto/pokemon_dto.dart';
import 'package:pokemon_trivia/data/source/remote/dto/pokemon_specie_url_dto.dart';
import 'package:pokemon_trivia/data/source/remote/dto/region_dto.dart';

class PokemonApi {
  final baseUrl = 'https://pokeapi.co/api/v2';

  // #region Pokemon

  Future<PokemonDto> getPokemon(int number) async {
    final url = '$baseUrl/pokemon/$number';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return PokemonDto.fromJson(json);
      } else {
        throw Exception('Failed to load pokemon $number');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching pokemon $number');
    }
  }

  Future<int> getPokemonCount() async {
    final url = '$baseUrl/pokemon-species';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final count = json['count'] as int;
        return count;
      } else {
        throw Exception('Failed to retrieve Pokemon count');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching Pokemon count');
    }
  }

  // #region Generation

  Future<List<GenerationDto>> getGenerations() async {
    final response = await http.get(Uri.parse('$baseUrl/generation'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final results = jsonResponse['results'] as List<dynamic>;
      final generationResults = results.map((result) {
        return GenerationDto.fromJson(result);
      }).toList();
      return generationResults;
    } else {
      throw Exception('Failed to fetch generation results');
    }
  }

  Future<GenerationDetailsDto> getGenerationDetails(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final regionUrl = jsonResponse['main_region']['url'] as String;
      final pokemonSpecies = jsonResponse['pokemon_species'] as List<dynamic>;
      final pokemonSpeciesUrlDto = pokemonSpecies
          .map((species) => PokemonSpecieUrlDto(
                name: species['name'] as String,
                url: species['url'] as String,
              ))
          .toList();

      return GenerationDetailsDto(
        mainRegionUrl: regionUrl,
        pokemonSpeciesUrlDto: pokemonSpeciesUrlDto,
      );
    } else {
      throw Exception('Failed to fetch generation details');
    }
  }

  Future<RegionDto> getRegionDetails(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final regionName = jsonResponse['name'] as String;
      return RegionDto(name: regionName);
    } else {
      throw Exception('Failed to fetch region details');
    }
  }
}
