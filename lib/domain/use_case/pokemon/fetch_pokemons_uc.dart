import 'package:pokemon_trivia/core/propagation/error.dart';
import 'package:pokemon_trivia/data/repo/generation_repo.dart';
import 'package:pokemon_trivia/data/repo/pokemon_repo.dart';
import 'package:pokemon_trivia/core/propagation/result.dart';
import 'package:pokemon_trivia/domain/model/generation_model.dart';
import 'package:pokemon_trivia/domain/model/pokemon_model.dart';

class FetchPokemonsUC {
  final PokemonRepository _pokemonRepository;
  final GenerationRepository _generationRepository;

  FetchPokemonsUC(
      {required PokemonRepository pokemonRepository,
      required GenerationRepository generationRepository})
      : _pokemonRepository = pokemonRepository,
        _generationRepository = generationRepository;

  /// This function will only try to fetch Pokemons only if there is new Pokemon
  /// available in the remote.
  Stream<Result<PokemonModel>> invoke(String generationCode) async* {
    final generation = await _generationRepository.getGeneration(generationCode);

    if (generation.data == null) {
      yield Result.error(RepoError.unknown);
      return;
    }

    final firstPokemon = generation.data!.startsWith;
    final lastPokemon = generation.data!.endsWith;

    for (int i = firstPokemon; i <= lastPokemon + 1; i++) {
      final pokemon = await _pokemonRepository.fetchPokemon(i);
      yield pokemon;
    }

    _generationRepository.updateGenerationAccessState(
        generation.data!.code, GenerationAccessState.pokemonsFetched);
  }
}
