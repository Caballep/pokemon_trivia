import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class FetchPokemonsUseCase {
  static const int totalPokemons = 35;
  final PokemonRepository pokemonRepository;

  FetchPokemonsUseCase({required this.pokemonRepository});

  Stream<PokemonModel> invoke() async* {
    for (int i = 1; i <= totalPokemons; i++) {
      final pokemon = await pokemonRepository.fetchPokemon(i);
      yield pokemon;
    }
  }
}
