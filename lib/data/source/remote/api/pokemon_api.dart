import 'package:pokemon_trivia/data/source/remote/dto/pokemon_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonApi {
  final baseUrl = "https://pokeapi.co/api/v2";

  Future<PokemonDto> fetchPokemon(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final pokemonDto = PokemonDto.fromJson(decoded);

      return pokemonDto;
    } else {
      throw Exception('Failed to fetch Pokemon details');
    }
  }
}
