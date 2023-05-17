import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_trivia/data/source/remote/dto/pokemon_dto.dart';

class PokemonApi {
  final baseUrl = 'https://pokeapi.co/api/v2';

  Future<PokemonDto> fetchPokemon(int number) async {
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
}
