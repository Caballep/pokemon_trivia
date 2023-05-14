import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';

class FetchPokemonsUseCase {
  final PokemonRepository pokemonRepository;

  FetchPokemonsUseCase(this.pokemonRepository);

  Stream<String> invoke(int totalPokemons) async* {
    for (int i = 1; i <= totalPokemons; i++) {
      final pokemon = await pokemonRepository.fetchPokemon(i);
      await pokemonRepository.fetchPokemon(i);
      yield pokemon;
    }
  }
}
