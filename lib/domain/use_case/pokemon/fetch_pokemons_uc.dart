import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/core/propagation/result.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class FetchPokemonsUC {
  final PokemonRepository pokemonRepository;

  FetchPokemonsUC({required this.pokemonRepository});

  /// This function will only try to fetch Pokemons only if there is new Pokemon
  /// available in the remote.
  Stream<Result<PokemonModel>> invoke() async* {
    final localPokemonCountResult =
        await pokemonRepository.getLocalPokemonCount();
    final remotePokemonCountResult =
        await pokemonRepository.getRemotePokemonCount();

    if (localPokemonCountResult.isError) {
      yield Result.error(localPokemonCountResult.error!);
      return;
    }

    if (remotePokemonCountResult.isError) {
      yield Result.error(remotePokemonCountResult.error!);
      return;
    }

    // final nextPokemonNumber = localPokemonCountResult.data!;
    // final lastPokemonNumber = remotePokemonCountResult.data!;

    // TODO: Remove this and uncomment the above 2 lines for release/production
    // This is to avoid overload the PokeApi and get the IP banned.
    final nextPokemonNumber = 11;
    final lastPokemonNumber = 25;

    for (int i = nextPokemonNumber; i <= lastPokemonNumber + 1; i++) {
      final pokemon = await pokemonRepository.fetchPokemon(i);
      yield pokemon;
    }
  }
}
